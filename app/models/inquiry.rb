class Inquiry < ApplicationRecord

  #Callbacks

  #Mixins/Plugins through Gems
  acts_as_paranoid
  #Associations
  belongs_to :user
  has_many :inquiry_items, inverse_of: :inquiry, dependent: :destroy
  has_many :quotes, ->{ posted_quotes }, dependent: :destroy
  has_one :selected_quote, ->{ select_quote }, class_name: "Quote"
  accepts_nested_attributes_for :inquiry_items, reject_if: :all_blank, allow_destroy: true
  has_many :conversations
  #Constants
  ORIGIN_LOCATION_TYPE = {src_residential: 'Residential', src_factory_warehouse: 'Factory / Warehouse', src_airport_port: 'Port / Airport (FOB)'}
  DESTINATION_LOCATION_TYPE = {dest_residential: 'Residential', dest_factory_warehouse: 'Factory / Warehouse', dest_airport_port: 'Port / Airport (FOB)'}
  STATUS = {pending: "Pending", receiving_quotes: "Receiving Quotes", closed: "Closed"}
  MODE_OF_FREIGHT = {air: "Air", sea: "Sea"}
  TYPE_OF_UNIT = {cartons: "Cartons", pallets: "Pallets"}
  INCO_TERM = {exw: "EXW", fob: "FOB", dap: "DAP", ddp: "DDP"}
  #Enums
  enum origin_location_type: ORIGIN_LOCATION_TYPE
  enum destination_location_type: DESTINATION_LOCATION_TYPE
  enum status: STATUS
  enum transport_mode: MODE_OF_FREIGHT
  enum item_type: TYPE_OF_UNIT
  enum inco_terms: INCO_TERM
  #Validations
  validates :origin_country, :origin_address,
   :destination_country, :destination_address,
   :goods_ready_date, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates :origin_location_type, inclusion: { in: origin_location_types.keys }
  validates :destination_location_type, inclusion: { in: destination_location_types.keys }
  validates :transport_mode, inclusion: { in: transport_modes.keys }
  validates :item_type, inclusion: { in: item_types.keys }
  validates :inco_terms, inclusion: { in: inco_terms.keys }
  validates_associated :inquiry_items
  #Scopes

  def self.not_current_user_inquiries(current_user)
    Inquiry.where("user_id != ?", current_user.id)
  end

  def self.current_user_friends_inquiries(current_user)
    Inquiry.where(user_id: current_user.get_friends_users_array.pluck(:id)).order! 'created_at DESC'
  end

  #Callback functions

  after_create :send_email
  after_update :destroy_recieved_quotes

  def destroy_recieved_quotes
    self.quotes.delete_all if self.quotes
    self.selected_quote.delete if self.selected_quote
    self.update_column(:status, Inquiry.statuses[:pending]) if self.status != Inquiry.statuses[:pending] 
  end

  def send_email
    users_arry = User.current_user.get_friends_users_array
    users_arry.each do |user|
      UserNotifierMailer.send_inquiry_email(user,self).deliver
    end
  end
end
