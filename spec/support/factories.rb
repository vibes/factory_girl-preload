FactoryGirl.define do
  factory :user do
    name "John Doe"
    sequence(:email) {|n| "john#{n}@doe.com"}
  end

  factory :skill do
    association :user
  end

  preload do
    factory(:john) { Factory(:user) }
    factory(:ruby) { Factory(:skill, :user => users(:john)) }
  end
end
