require 'rails_helper'

RSpec.describe CreateSeasonForm, type: :model do
  let(:matty) { create(:user) }

  let(:chicago_team_code) { "CHI" }

  subject(:form) { CreateSeasonForm.new(owner: matty, owner_team_code: chicago_team_code) }

  it "creates new joinable season" do
    expect(form).to be_valid
    expect(form.save).to be_truthy

    expect(form.season).to be_persisted
    expect(form.season).to be_joinable
  end

  it "creates new unjoinable season" do
    form.joinable = false

    expect(form).to be_valid
    expect(form.save).to be_truthy

    expect(form.season).to be_persisted
    expect(form.season).not_to be_joinable
  end

  it "creates owner team" do
    expect(form).to be_valid
    expect(form.save).to be_truthy

    expect(form.season.teams.count).to eq(1)
    expect(form.season.teams.first.user).to eq(matty)
    expect(form.season.teams.first.code).to eq(chicago_team_code)
  end
end
