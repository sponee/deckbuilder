class RenameDecksToPathfinderDecks < ActiveRecord::Migration
  def change
    rename_table :decks, :pathfinder_decks
  end
end
