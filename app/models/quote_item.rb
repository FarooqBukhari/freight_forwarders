class QuoteItem < ApplicationRecord
  #Callbacks

  #Mixins/Plugins through Gems
  acts_as_paranoid
  #Associations
  belongs_to :quote
  #Constants
  ITEM_TYPE = {origin: "Origin", destination: "Destination", carrier: "Carrier"}
  CARRIER_NAME = {turkish_airline: "Turkish Airline", pia: "Pakistan Airline"}
  #Enums
  enum item_type: ITEM_TYPE
  enum carrier_name: CARRIER_NAME
  #Validations
  validates :name, presence: true
  validates :amount, numericality: true
  validates :item_type, inclusion: { in: item_types.keys }
  #Scopes
  scope :carrier_items, ->{ where(item_type: item_types[:carrier]) }
  scope :origin_items, ->{ where(item_type: item_types[:origin]) }
  scope :destination_items, ->{ where(item_type: item_types[:destination]) }
  #Callback functions
end
