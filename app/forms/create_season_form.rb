class CreateSeasonForm < ApplicationForm
  attr_accessor :user

  attribute :team_code, :string

  validates :team_code,
    presence: true,
    inclusion: { in: Team::TEAM_CODES, allow_blank: true }

  attr_reader :season

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      @season = Season.create!
      @season.teams.create!(user:, code: team_code, admin: true)
    end

    true
  end
end
