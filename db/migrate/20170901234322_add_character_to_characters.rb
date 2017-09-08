class AddCharacterToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :character, :string
  end
end
