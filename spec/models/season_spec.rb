require 'rails_helper'

RSpec.describe Season, type: :model do
  describe "creation" do
    context "when joinable" do
      it "assigns join_code" do
        season = Season.create!

        expect(season.join_code).to be_present
      end
    end

    context "when not joinable" do
      it "does not assign join_code" do
        season = Season.create!(joinable: false)

        expect(season.join_code).to be_nil
      end
    end
  end

  describe "#available_team_codes" do
    it "returns the available team codes for the season" do
      season = create(:season, :with_owner)

      expect(season.available_team_codes).to match_array(Team::TEAM_CODES - [ 'CHI' ])
    end
  end
end
