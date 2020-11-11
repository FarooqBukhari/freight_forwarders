class QuoteItem < ApplicationRecord
  #Callbacks

  #Mixins/Plugins through Gems
  acts_as_paranoid

  #Associations
  belongs_to :quote

  #Enums
  enum item_type: {origin: "Origin", destination: "Destination", carrier: "Carrier"}
  enum carrier_name: {turkish_airline: "Turkish Airline", pia: "Pakistan Airline"}

  #Validations

  #Scopes

  #Callback functions
end
