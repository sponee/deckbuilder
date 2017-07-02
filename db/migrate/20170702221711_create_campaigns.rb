class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :gm_user_id
      t.text :description
      t.string :simulator_url
      t.time :next_session

      t.timestamps null: false
    end
  end
end
