class Quote < ApplicationRecord
  #Callbacks

  #Mixins/Plugins through Gems
  acts_as_paranoid

  #Associations
  belongs_to :user
  belongs_to :inquiry

  #Validations

  #Scopes

  #Callback functions

end
