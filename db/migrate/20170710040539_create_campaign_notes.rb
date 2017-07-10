class CreateCampaignNotes < ActiveRecord::Migration
  def change
    create_table :campaign_notes do |t|
      t.string :name
      t.text :content
      t.integer :user_id
      t.integer :campaign_id
      t.date :session_date

      t.timestamps null: false
    end
  end
end
