class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    group = Group.find(params[:group_id])
    stream_for group
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    # Broadcasting the message to the group
    message = Message.create!(content: data['message'], group: @group, user: current_user)
    
    # You can broadcast to the group using `broadcast_to`
    ChatChannel.broadcast_to(@group, { message: message.content, user: message.user.username })
  end
end
