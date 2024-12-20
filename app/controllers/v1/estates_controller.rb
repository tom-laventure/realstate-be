require 'open-uri'
require 'nokogiri'
require 'cgi'

class V1::EstatesController < ApplicationController
    include UserValidation, Pagination

    before_action :auth_user
    before_action :set_group, except: [:preview_data]
    before_action :set_estate, only: [:show, :update, :destroy]
  
    # GET /estates
    def index
      order = params['orderby']
      
      estates = {
        estates: ActiveModelSerializers::SerializableResource.new(@group.order_estates(order, @current_user), each_serializer: EstateSerializer, current_user: current_user),
        group: ActiveModelSerializers::SerializableResource.new(@group, serializer: GroupSerializer)
      }
      render json: estates, status: :ok
    end
  
    # GET /estates/:id
    def show
      paginated_comments = ActiveModelSerializers::SerializableResource.new(@estate.estate_comments.then(&paginate), each_serializer: EstateCommentSerializer, current_user: current_user)
      selected_estate = ActiveModelSerializers::SerializableResource.new(@estate, serializer: EstateSerializer, current_user: current_user, comments: paginated_comments)

      estates = {
        estates: ActiveModelSerializers::SerializableResource.new(@group.estates, each_serializer: EstateSerializer),
        selected_estate: selected_estate,
      } 

      render json: estates, status: :ok   
    end
  
    # POST /estates
    def create
      estate = @group.estates.new(estate_params)
  
      if estate.save
        render json: { status: 200, message: 'Estate successfully created', data: estate }, status: :ok
      else
        render json: { status: 422, message: 'Error creating estate', errors: estate.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PUT /estates/:id
    def update
      if @estate.update(estate_params)
        render json: { status: 200, message: 'Estate successfully updated', data: @estate }, status: :ok
      else
        render json: { status: 422, message: 'Error updating estate', errors: @estate.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /estates/:id
    def destroy
      if @estate.destroy
        render json: { status: 200, message: 'Estate successfully deleted' }, status: :ok
      else
        render json: { status: 422, message: 'Error deleting estate' }, status: :unprocessable_entity
      end
    end

    def preview_data
      url = CGI.unescape(params[:url])

      if url.blank? || url.length > 2048
        render json: { error: 'Invalid or too long URL parameter' }, status: :bad_request
        return
      end

      begin
        html = URI.open(url, "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36").read
        document = Nokogiri::HTML(html)
        Rails.logger.info("Document #{document}")
        # Extract metadata
        image = document.at('meta[property="og:image"]')&.[]('content') ||
                document.at('meta[name="twitter:image"]')&.[]('content')
        title = document.at('meta[property="og:title"]')&.[]('content') ||
                document.at('title')&.text
        description = document.at('meta[property="og:description"]')&.[]('content') ||
                      document.at('meta[name="description"]')&.[]('content')

        price = title&.match(/\$\d{1,3}(,\d{3})*(\.\d{2})?/)&.to_s
      
        render json: { image: image, header: title, description: description, price: price }
      end

    end
  
    private

    def set_group
      @group = @current_user.groups.without_deleted.find(params['group_id'])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Group not found' }, status: :not_found
    end
  

    def set_estate
      @estate = @group.estates.without_deleted.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Estate not found' }, status: :not_found
    end
  

    def estate_params
      params.require(:estate).permit(:header, :link, :image, :price)
    end
  end
  