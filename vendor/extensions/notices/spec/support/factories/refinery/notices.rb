
FactoryGirl.define do
  factory :notice, :class => Refinery::Notices::Notice do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

