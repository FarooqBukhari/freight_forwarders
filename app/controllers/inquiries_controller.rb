class InquiriesController < ApplicationController
  include Geokit::Geocoders
  before_action :authenticate_user!
  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /inquiries
  # GET /inquiries.json
  def index
    @inquiries = Inquiry.where("user_id != ?", current_user.id)
  end

  # GET /inquiries/1
  # GET /inquiries/1.json
  def show
  end

  # GET /inquiries/new
  def new
    @inquiry = Inquiry.new
    1.times {@inquiry.inquiry_items.build}
  end

  # GET /inquiries/1/edit
  def edit
  end

  # POST /inquiries
  # POST /inquiries.json
  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.user_id = current_user.id
    respond_to do |format|
      if @inquiry.save
        format.html { redirect_to @inquiry, notice: 'Inquiry was successfully created.' }
        format.json { render :show, status: :created, location: @inquiry }
      else
        format.html { render :new }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inquiries/1
  # PATCH/PUT /inquiries/1.json
  def update
    respond_to do |format|
      if @inquiry.update(inquiry_params)
        format.html { redirect_to @inquiry, notice: 'Inquiry was successfully updated.' }
        format.json { render :show, status: :ok, location: @inquiry }
      else
        format.html { render :edit }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inquiries/1
  # DELETE /inquiries/1.json
  def destroy
    @inquiry.destroy
    respond_to do |format|
      format.html { redirect_to my_inquiries_user_url(current_user), notice: 'Inquiry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_address_suggestions
    search_query = params['address'] + ', ' + params['country']
    puts search_query
    geo = MultiGeocoder.geocode(search_query)
    address_suggestion = geo.full_address
    render json: {suggestion: address_suggestion}
  end

  private
  def check_user
    redirect_to root_path if current_user.id != @inquiry.user_id
  end

  def set_inquiry
    @inquiry = Inquiry.eager_load(:inquiry_items, :quotes, :selected_quote).find(params[:id])
  end

  def inquiry_params
    params.require(:inquiry).permit(:origin_location_type, :origin_country, :origin_address,
       :destination_location_type, :destination_country, :destination_address, :goods_ready_date, :destination_lat, :destination_lng,
        :origin_lat, :origin_lng, inquiry_items_attributes: [:id, :commodity, :number_of_units, :length, :width, :heigth, :weight, :_destroy])
  end
end
