class Season < ApplicationRecord
  include WorkflowActiverecord

  workflow do
    state :waiting_for_users
  end

  has_many :teams, dependent: :destroy

  before_create :assign_join_code

  validates :join_code, uniqueness: { allow_nil: true }, length: { maximum: 64 }

  def available_team_codes
    Team::TEAM_CODES - teams.pluck(:code)
  end

  private

  def assign_join_code
    self.join_code = SecureRandom.hex(10)
  end
end
