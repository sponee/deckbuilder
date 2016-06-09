class AddDocumentPathToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :document_path, :string
  end
end
