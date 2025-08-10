require 'rails_helper'

RSpec.describe Season, type: :model do
  describe "creation" do
    it "assigns join_code" do
      season = Season.create!

      expect(season.join_code).to be_present
    end
  end

  describe "#available_team_codes" do
    it "returns the available team codes for the season" do
      season = create(:season, :with_user)

      expect(season.available_team_codes).to match_array(Team::TEAM_CODES - [ 'CHI' ])
    end
  end
end
