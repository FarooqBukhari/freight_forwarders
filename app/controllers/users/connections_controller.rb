class Users::ConnectionsController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        @q = User.search(params[:q])
        @users = @q.result
        @pagy, @connections = pagy((current_user.my_friends), items: 10)
    end
end
