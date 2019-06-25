class MessagesController < ApplicationController
  before_action :get_messages

  def index
    @vacation = Vacation.find(params[:id])
  end

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast 'room_channel',
                                    content: message.content,
                                    username: message.user.first_name
                                    
      message.mentions.each do |mention|
        ActionCable.server.broadcast "room_channel_user_#{mention.id}",
                                     mention: true
      end
    end
  end

  private

  def get_messages
    @messages = Message.for_display
    @message = current_user.messages.build
  end

  def message_params
    params.require(:message).permit(:content).merge(vacation_id: params[:id])
  end
end
