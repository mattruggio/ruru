require 'rails_helper'

RSpec.describe User, type: :model do
  describe "creation" do
    it "creates a user with email and password" do
      user = User.create!(email_address: "matty@example.com", password: "abc123!", password_confirmation: "abc123!")

      expect(user).to be_persisted
      expect(user.email_address).to be_present
      expect(user.authenticate("abc123!")).to eq(user)
    end

    it "is invalid without an email" do
      user = User.new(email_address: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email_address]).to be_present
    end
  end
end
