class Inquiry < ApplicationRecord

  #Callbacks
  after_create :status_change
  #Mixins/Plugins through Gems
  acts_as_paranoid
  #Associations
  belongs_to :user
  has_many :inquiry_items, inverse_of: :inquiry, dependent: :destroy
  has_many :quotes, inverse_of: :inquiry, dependent: :destroy
  has_one :selected_quote, class_name: "Quote", inverse_of: :inquiry
  accepts_nested_attributes_for :inquiry_items, reject_if: :all_blank, allow_destroy: true

  #Validations

  #Enums
  enum origin_location_type: {src_residential: 'Residential', src_factory_warehouse: 'Factory / Warehouse', src_airport_port: 'Port / Airport (FOB)'}
  enum destination_location_type: {dest_residential: 'Residential', dest_factory_warehouse: 'Factory / Warehouse', dest_airport_port: 'Port / Airport (FOB)'}
  enum status: [:pending, :receiving_quotes, :selected]
  #Scopes

  def self.not_current_user_inquiries(current_user)
    Inquiry.where("user_id != ?", current_user.id)
  end
  #Callback functions
  private
  def status_change
    if !selected_quote.nil?
      self.selected!
    else
      if quotes.count > 0 && self.pending?
        self.in_discussion!
      else if status.nil?
        self.pending!
      end
    end
  end
end
end
