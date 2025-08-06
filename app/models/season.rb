class Season < ApplicationRecord
  has_many :teams, dependent: :destroy

  before_create :assign_join_code

  validates :join_code, uniqueness: { allow_nil: true }, length: { maximum: 64 }

  def available_team_codes
    Team::TEAM_CODES - teams.pluck(:code)
  end

  private

  def assign_join_code
    self.join_code = joinable? ? SecureRandom.hex(32) : nil
  end
end
