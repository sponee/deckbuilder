class Character < ActiveRecord::Base
  belongs_to :user
  mount_uploader :attachment, CharacterUploader # Tells rails to use this uploader for this model.
end
