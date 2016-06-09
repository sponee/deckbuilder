class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.text :cards
      t.text :contents
      t.references :user, index: true, foreign_key: true
    end
  end
end
