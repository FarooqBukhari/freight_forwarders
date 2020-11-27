class ApplicationController < ActionController::Base
  include Pagy::Backend
  # before_action :get_convo
  #
  # def get_convo
  #   if current_user
  #     session[:conversations] ||= []
  #     @users = User.all.where.not(id: current_user)
  #     # @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  #     @conversations = Conversation.where(recipient_id: current_user).or( Conversation.where(sender_id: current_user) )
  #   end
  # end
  #
  before_action :set_current_user

  private

  def set_current_user
    User.current_user = current_user
  end
end
