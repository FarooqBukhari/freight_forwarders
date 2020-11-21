class HomeController < ApplicationController
  def index
    render :'home/dashboard'
  end
end
