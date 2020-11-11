class Inquiry < ApplicationRecord
  #Mixins/Plugins through Gems
  acts_as_paranoid
  #Associations
  belongs_to :user
  has_many :inquiry_items, inverse_of: :inquiry, dependent: :destroy
  accepts_nested_attributes_for :inquiry_items, reject_if: :all_blank, allow_destroy: true
  has_many :conversations
  #Validations

  #Enums
  enum origin_location_type: {src_residential: 'Residential', src_factory_warehouse: 'Factory / Warehouse', src_airport_port: 'Port / Airport (FOB)'}
  enum destination_location_type: {dest_residential: 'Residential', dest_factory_warehouse: 'Factory / Warehouse', dest_airport_port: 'Port / Airport (FOB)'}

  #Scopes
end
