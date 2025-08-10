FactoryBot.define do
  factory :season do
    trait :with_user do
      transient do
        user { create(:user) }
        team_code { "CHI" }
      end

      after(:build) do |season, evaluator|
        season.teams << build(:team, user: evaluator.user, code: evaluator.team_code)
      end
    end
  end
end
