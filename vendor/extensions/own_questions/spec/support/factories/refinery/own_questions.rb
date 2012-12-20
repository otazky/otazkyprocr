
FactoryGirl.define do
  factory :own_question, :class => Refinery::OwnQuestions::OwnQuestion do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

