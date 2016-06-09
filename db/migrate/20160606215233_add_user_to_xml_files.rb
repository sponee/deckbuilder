class AddUserToXmlFiles < ActiveRecord::Migration
  def change
    add_reference :xml_files, :user, index: true, foreign_key: true
  end
end
