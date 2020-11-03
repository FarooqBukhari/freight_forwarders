class InquiriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:edit, :new]

  def index
  end

  def new
    @inquiry = Inquiry.new
    1.times {@inquiry.inquiry_items.build}
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.user_id = current_user.id
    if @inquiry.save

      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @inquiry.update_attributes(inquiry_params)
     redirect_to root_path
    else
     render :edit
    end
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

  def set_user
    @user = User.find(current_user.id)
  end

  def inquiry_params
    params.require(:inquiry).permit(:origin_location_type, :origin_country, :origin_address,
       :destination_location_type, :destination_country, :destination_address, :goods_ready_date,
        inquiry_items_attributes: [:id, :commodity, :number_of_units, :length, :width, :heigth, :weight, :_destroy])
  end
end
