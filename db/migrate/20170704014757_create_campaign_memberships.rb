class CreateCampaignMemberships < ActiveRecord::Migration
  def change
    create_table :campaign_memberships do |t|
      t.integer :user_id
      t.integer :campaign_id

      t.timestamps null: false
    end
  end
end
