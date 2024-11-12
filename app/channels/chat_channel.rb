class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    group = Group.find(params[:group_id])
    stream_for group
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
