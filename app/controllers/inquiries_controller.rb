class InquiriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @inquiry = Inquiry.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def delete
  end


  private
  def check_user
    redirect_to root_path if current_user.id != @inquiry.user_id
  end

  def set_inquiry
    @inquiry = Inquiry.eager_load(:inquiry_items).find(params[:id])
  end

  def inquiry_params
    params.require(:inquiry).permit(:origin_location_type, :origin_country, :origin_address,
       :destination_location_type, :destination_country, :destination_address, :goods_ready_date,
        inquiry_items: [:id, :commodity, :number_of_units, :length, :width, :height, :weight, :_destroy])
  end
end
