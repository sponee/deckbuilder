class AddNextSessionToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :next_session, :date
  end
end
