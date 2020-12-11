class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :my_inquiries, :my_calender, :edit, :update, :destroy, :friends]

  # GET /users
  # GET /users.json
  def index
    # users_to_remove = current_user.get_friends_users_array
    users_to_remove = []
    users_to_remove = users_to_remove << current_user
    users_to_remove = users_to_remove.pluck(:id)
    @q = User.search(params[:q])
    @users = @q.result
    @pagy, @users = pagy(@users.where.not(id: users_to_remove), items: 10)
    @recommendations = current_user.strangers
    @friend_requests = current_user.requested_users
    @requested_users = current_user.requested_users.pluck(:requester_id)
    @requester_users = current_user.requester_users.pluck(:requested_id)
  end

  def my_inquiries
    @inquiries = @user.inquiries.order! 'created_at DESC'
    @pagy, @inquiries_network = pagy(Inquiry.current_user_friends_inquiries(current_user).where(destination_country: current_user.country), items: 5)
    @tab = params[:page] == nil ? "" : "networkInqTab"
  end

  def my_calender
    @inquiries = Inquiry.all
  end

  def friends
    @friends = @user.get_friend_users
    @is_friend = current_user.isFriend(@user).exists?
    @can_add =  ( !current_user.isFriend(@user).exists? && !current_user.requester_users.find_by(requested_id: @user.id) )
    @can_remove = current_user.requester_users.find_by(requested_id: @user.id)
    @can_accept = current_user.requested_users.find_by(requester_id: @user.id)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if current_user == @user
      @pagy, @inquiries = pagy(current_user.quoted_inquiry, items: 5)
    else
      @pagy, @inquiries = pagy(@user.inquiries, items: 5)
    end
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
      params.require(:user).permit(:name, :phone, :website, :job_title, :profile_picture, :cover_photo, :company_name, :country)
    end
end
