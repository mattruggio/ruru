require 'rails_helper'

RSpec.describe CreateSeasonForm, type: :model do
  let(:matty) { create(:user) }

  let(:chicago_team_code) { "CHI" }

  subject(:form) { CreateSeasonForm.new(user: matty, team_code: chicago_team_code) }

  it "creates new season" do
    expect(form).to be_valid
    expect(form.save).to be_truthy

    expect(form.season).to be_persisted
  end

  it "creates team" do
    expect(form).to be_valid
    expect(form.save).to be_truthy

    expect(form.season.teams.count).to eq(1)
    expect(form.season.teams.first.user).to eq(matty)
    expect(form.season.teams.first.code).to eq(chicago_team_code)
  end
end
