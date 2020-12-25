class InquiryItem < ApplicationRecord
  #Mixins/Plugins through Gems
  acts_as_paranoid
  #Associations
  belongs_to :inquiry

  #Validations
  validates :commodity, presence: true
  validates :number_of_units, numericality: { only_integer: true }
  validates :length, :width, :heigth, :weight, numericality: true
  #Scopes

  after_update :destroy_recieved_quotes

  def destroy_recieved_quotes
    self.inquiry.quotes.delete_all if self.quotes
    self.inquiry.selected_quote.delete if self.selected_quote
    self.inquiry.update_column(:status, Inquiry.statuses[:pending]) if self.inquiry.status != Inquiry.statuses[:pending]
  end

end
