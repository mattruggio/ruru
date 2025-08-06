FactoryBot.define do
  factory :team do
    user { create(:user) }
    code { "CHI" }
  end
end
