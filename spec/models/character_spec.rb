require 'rails_helper'

RSpec.describe Character, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:attachment) }
end
