class JoinSeasonForm < ApplicationForm
  attr_accessor :user, :season

  attribute :team_code, :string

  validates :team_code,
    presence: true,
    inclusion: { in: ->(f) { f.season.available_team_codes }, allow_blank: true, message: "is already taken" }

  validates :season, presence: true

  validates :user, presence: true

  delegate :available_team_codes, to: :season

  def save
    return false unless valid?

    season.teams.create!(user:, code: team_code)

    true
  end
end
