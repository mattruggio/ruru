class Team < ApplicationRecord
  TEAMS_BY_CODE = {
    "ATL": "Atlanta",
    "BKN": "Brooklyn",
    "BOS": "Boston",
    "CHA": "Charlotte",
    "CHI": "Chicago",
    "CLE": "Cleveland",
    "DAL": "Dallas",
    "DEN": "Denver",
    "DET": "Detroit",
    "GSW": "Golden State",
    "HOU": "Houston",
    "IND": "Indiana",
    "LAC": "Los Angeles C",
    "LAL": "Los Angeles L",
    "MEM": "Memphis",
    "MIA": "Miami",
    "MIL": "Milwaukee",
    "MIN": "Minnesota",
    "NOP": "New Orleans",
    "NYK": "New York",
    "OKC": "Oklahoma City",
    "ORL": "Orlando",
    "PHI": "Philadelphia",
    "PHX": "Phoenix",
    "POR": "Portland",
    "SAC": "Sacramento",
    "SAS": "San Antonio",
    "TOR": "Toronto",
    "UTA": "Utah",
    "WSH": "Washington"
  }.freeze

  TEAM_CODES = TEAMS_BY_CODE.keys.map(&:to_s).freeze

  belongs_to :season

  belongs_to :user, optional: true

  validates :code,
    presence: true,
    length: { maximum: 3 },
    inclusion: { allow_blank: true, in: TEAM_CODES }

  after_commit :broadcast_lobby_update

  def not_admin?
    !admin?
  end

  private

  def broadcast_lobby_update
    season.broadcast_async_lobby_update
  end
end
