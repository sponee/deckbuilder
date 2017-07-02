class RemoveNextSessionFromCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :next_session, :time
  end
end
