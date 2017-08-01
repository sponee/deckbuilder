FactoryGirl.define do
  factory :campaign_note do
    name "MyString"
    content "MyText"
    user_id 1
    campaign_id 1
    description "Description"
    session_date "2017-07-10"
  end
end
