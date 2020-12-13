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
  before_action :check_user_validity, except: [:destroy]

  private

  def set_current_user
    User.current_user = current_user
  end

  def check_user_validity
    if !current_user.nil? && !current_user.valid?
      if params[:controller] != 'after_signup'
        if !( (params[:action] == 'edit' || params[:action] == 'update') && params[:controller] == 'users')
          flash[:alert] = 'Kindly complete your profile!'
          redirect_to edit_user_path(current_user)
        end
      end
    end
  end
end
