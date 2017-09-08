class AddAttachmentToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :attachment, :string
  end
end
