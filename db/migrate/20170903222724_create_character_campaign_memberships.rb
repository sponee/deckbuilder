class CreateCharacterCampaignMemberships < ActiveRecord::Migration
  def change
    create_table :character_campaign_memberships do |t|
      t.integer :character_id
      t.integer :campaign_id

      t.timestamps null: false
    end
  end
end
