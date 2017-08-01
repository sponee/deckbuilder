require 'rails_helper'

RSpec.describe CampaignNote, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:session_date) }
end
