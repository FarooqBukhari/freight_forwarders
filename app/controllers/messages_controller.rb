class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    session[:conversations] ||= []
    @id = params[:id]
    @users = User.all.where.not(id: current_user)
    # @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
    @conversations = Conversation.where(recipient_id: current_user).or( Conversation.where(sender_id: current_user) )
    @id = @id.to_i
  end

  def read
    @id = params[:id]
    @conversation = Conversation.find(@id)
    @messages = @conversation.messages
    @messages.each do |msg|
      if msg.user_id != current_user.id
        msg.mark_as_read! for: current_user
      end
    end
  end

  private

  def message_params
    params.permit(:user_id, :body, :id)
  end
end
