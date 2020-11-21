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

  private

  def message_params
    params.permit(:user_id, :body, :id)
  end
end
