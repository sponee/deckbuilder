class CreateCampaignInvitations < ActiveRecord::Migration
  def change
    create_table :campaign_invitations do |t|
      t.integer :sender_id
      t.integer :campaign_id
      t.string :recipient_email
      t.string :token
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
