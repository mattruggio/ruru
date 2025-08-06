class CreateSeasonForm < ApplicationForm
  attr_accessor :owner

  attribute :owner_team_code, :string

  attribute :joinable, :boolean, default: true

  validates :owner_team_code,
    presence: true,
    inclusion: { in: Team::TEAM_CODES, allow_blank: true }

  attr_reader :season

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      @season = Season.create!(joinable:)
      @season.teams.create!(user: owner, code: owner_team_code)
    end

    true
  end
end
