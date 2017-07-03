class RemoveGmUserIdFromCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :gm_user_id, :integer
  end
end
