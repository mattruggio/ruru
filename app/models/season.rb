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

  def admin?(user)
    teams.select { |t| t.user_id == user.id && t.admin? }.any?
  end

  def user?(user)
    teams.where(user:).any?
  end

  def broadcast_async_lobby_update
    return unless waiting_for_users?

    broadcast_render_later_to(
      [ self, "lobby" ],
      partial: "seasons/lobby/teams",
      formats: %i[turbo_stream],
      locals: { season: self }
    )
  end

  private

  def assign_join_code
    self.join_code = SecureRandom.hex(10)
  end
end
