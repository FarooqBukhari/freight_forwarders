class Quote < ApplicationRecord
  #Callbacks
  after_create :update_total_price
  after_create :change_inquiry_status
  after_update :change_inquiry_status
  after_destroy :change_inquiry_status
  #Mixins/Plugins through Gems
  acts_as_paranoid
  #Associations
  belongs_to :user
  belongs_to :inquiry
  has_many :carrier_quote_items, ->{ carrier_items }, class_name: "QuoteItem", inverse_of: :quote
  has_many :origin_quote_items, ->{ origin_items }, class_name: "QuoteItem", inverse_of: :quote
  has_many :destination_quote_items, ->{ destination_items }, class_name: "QuoteItem", inverse_of: :quote
  accepts_nested_attributes_for :carrier_quote_items, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :origin_quote_items, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :destination_quote_items, reject_if: :all_blank, allow_destroy: true
  #Constants
  STATUS = {posted: "Posted", selected: "Selected"}
  #Enums
  enum status: STATUS
  #Validations
  validates :status, inclusion: { in: statuses.keys }
  validates_associated :carrier_quote_items, :origin_quote_items, :destination_quote_items
  #Scopes
  scope :select_quote, ->{ where(status: statuses[:selected]) }
  scope :posted_quotes, ->{ where(status: statuses[:posted]) }
  #Callback functions
  private
  def update_total_price
    self.update_column(:total_price, self.carrier_quote_items.pluck(:amount).sum + self.origin_quote_items.pluck(:amount).sum + self.destination_quote_items.pluck(:amount).sum)
  end
  def change_inquiry_status
    self.inquiry.update_column(:status, Inquiry.statuses[:receiving_quotes]) if self.inquiry.selected_quote.nil? && self.inquiry.status != Inquiry.statuses[:receiving_quotes]
    self.inquiry.update_column(:status, Inquiry.statuses[:closed]) if self.inquiry.selected_quote.present?
    self.inquiry.update_column(:status, Inquiry.statuses[:pending]) if self.inquiry.selected_quote.nil? && self.inquiry.quotes.blank?
  end
end
