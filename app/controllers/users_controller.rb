class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :my_inquiries, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @pagy, @users = pagy(User.all, items: 10)
    @recommendations = current_user.strangers
    @requested_users = current_user.requested_users
  end

  def my_inquiries
    @inquiries = @user.inquiries
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @inquiries = @user.inquiries
    @is_friend = current_user.isFriend(@user).exists?
    @can_add =  ( !current_user.isFriend(@user).exists? && !current_user.requester_users.find_by(requested_id: @user.id) )
    @can_remove = current_user.requester_users.find_by(requested_id: @user.id)
    @can_accept = current_user.requested_users.find_by(requester_id: @user.id)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end
end
