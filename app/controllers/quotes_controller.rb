class QuotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inquiry, only: [:show, :new, :create, :edit, :update, :destroy, :select_quote, :deselect_quote]
  before_action :set_quote, only: [:show, :edit, :update, :destroy, :select_quote, :deselect_quote]
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    1.times {@quote.carrier_quote_items.new}
    1.times {@quote.origin_quote_items.new}
    1.times {@quote.destination_quote_items.new}
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.inquiry_id = @inquiry.id
    @quote.user_id = current_user.id
    respond_to do |format|
      if @quote.save
        format.html { redirect_to @inquiry, notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @inquiry, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to @inquiry, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_quote
    respond_to do |format|
      if @quote.update(status: Quote.statuses[:selected])
        format.html { redirect_to @inquiry, notice: 'Quote was successfully selected.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { redirect_to @inquiry, error: 'Something went wrong while selecting Quote' }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  def deselect_quote
    respond_to do |format|
      if @quote.update(status: Quote.statuses[:posted])
        format.html { redirect_to @inquiry, notice: 'Quote was successfully selected.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { redirect_to @inquiry, error: 'Something went wrong while selecting Quote' }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.eager_load(:carrier_quote_items, :origin_quote_items, :destination_quote_items).find(params[:id])
    end
    private
    def check_user
      redirect_to root_path if current_user.id != @quote.user_id
    end

    def set_inquiry
      @inquiry = Inquiry.find(params[:inquiry_id])
    end

    def quote_params
      params.require(:quote).permit(carrier_quote_items_attributes: [:id, :name, :item_type, :amount, :routing, :_destroy],
        origin_quote_items_attributes: [:id, :name, :item_type, :amount, :_destroy],
        destination_quote_items_attributes: [:id, :name, :item_type, :amount, :_destroy])
    end
end
