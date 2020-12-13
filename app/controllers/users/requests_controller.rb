class Users::RequestsController < ApplicationController
    before_action :authenticate_user!

    def index 
        @q = User.search(params[:q])
        @users = @q.result
        @pagy, @requests = pagy((current_user.requested_users), items: 10)
    end
end
