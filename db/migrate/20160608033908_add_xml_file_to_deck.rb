class AddXmlFileToDeck < ActiveRecord::Migration
  def change
    add_column :decks, :xml_file, :string
  end
end
