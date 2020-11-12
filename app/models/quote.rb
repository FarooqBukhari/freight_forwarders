class Quote < ApplicationRecord
  #Callbacks
  after_create :status_change
  after_create :update_total_price
  #Mixins/Plugins through Gems
  acts_as_paranoid

  #Associations
  belongs_to :user
  belongs_to :inquiry
  has_many :carrier_quote_items, class_name: "QuoteItem", inverse_of: :quote
  has_many :origin_quote_items, class_name: "QuoteItem", inverse_of: :quote
  has_many :destination_quote_items, class_name: "QuoteItem", inverse_of: :quote
  accepts_nested_attributes_for :carrier_quote_items, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :origin_quote_items, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :destination_quote_items, reject_if: :all_blank, allow_destroy: true

  #Enums
  enum status: {posted: "Posted", selected: "Selected"}

  #Validations

  #Scopes

  #Callback functions
  private
  def status_change
    self.posted!
  end

  def update_total_price
    self.update_column(:total_price, self.carrier_quote_items.pluck(:amount).sum + self.origin_quote_items.pluck(:amount).sum + self.destination_quote_items.pluck(:amount).sum)
  end
end
