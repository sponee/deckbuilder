require 'rails_helper'

RSpec.describe CampaignMembership, type: :model do
  it { should validate_presence_of(:campaign_id)}
  it { should validate_presence_of(:user_id)}
  it { should validate_uniqueness_of(:user_id).scoped_to(:campaign_id) }
end
