FactoryGirl.define do
  factory :campaign_invitation do
    sender_id 1
    campaign_id 1
    recipient_email "MyString"
    token "MyString"
    accepted nil
  end
end
