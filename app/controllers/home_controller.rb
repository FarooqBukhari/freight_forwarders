class HomeController < ApplicationController
  layout "landing", except: [:index]
  def index
    render :'home/dashboard'
  end

  def show
  end
end
