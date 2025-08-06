FactoryBot.define do
  factory :season do
    trait :with_owner do
      transient do
        owner { create(:user) }
        owner_team_code { "CHI" }
      end

      after(:build) do |season, evaluator|
        season.teams << build(:team, user: evaluator.owner, code: evaluator.owner_team_code)
      end
    end
  end
end
