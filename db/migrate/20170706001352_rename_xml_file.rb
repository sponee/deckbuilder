class RenameXmlFile < ActiveRecord::Migration
  def change
    rename_column :pathfinder_decks, :xml_file, :xml_file_id
  end
end