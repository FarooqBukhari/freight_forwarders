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

end
