class CreateSeasonForm < ApplicationForm
  attr_accessor :owner

  attribute :owner_team_code, :string

  validates :owner_team_code,
    presence: true,
    inclusion: { in: Team::TEAM_CODES, allow_blank: true }

  attr_reader :season

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      @season = Season.create!
      @season.teams.create!(user: owner, code: owner_team_code, admin: true)
    end

    true
  end
end
