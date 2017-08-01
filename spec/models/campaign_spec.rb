require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:next_session) }
  it { should validate_presence_of(:description) }
end
