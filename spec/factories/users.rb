FactoryBot.define do
  factory :user do
    email_address { "mattycakes-#{SecureRandom.uuid}@coachcommander.app" }
    password { "abc123!" }
    password_confirmation { "abc123!" }
  end
end
