class AfterSignupController < ApplicationController
  before_action :authenticate_user!
  include Wicked::Wizard

  steps :personal
  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    render_wizard @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :website, :job_title)
  end
end
