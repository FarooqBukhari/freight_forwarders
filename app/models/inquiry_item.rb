class InquiryItem < ApplicationRecord
  #Mixins/Plugins through Gems
  acts_as_paranoid
  #Associations
  belongs_to :inquiry

  #Validations

  #Scopes

end
