class AddDescriptionToCampaignNotes < ActiveRecord::Migration
  def change
    add_column :campaign_notes, :description, :string
  end
end
