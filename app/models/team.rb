class Team < ApplicationRecord
  belongs_to :season

  belongs_to :user, optional: true

  validates :code,
    presence: true,
    length: { maximum: 3 },
    uniqueness: { scope: :season_id }

  validates :location,
    presence: true,
    length: { maximum: 100 }

  validates :name,
    presence: true,
    length: { maximum: 100 }

  normalizes :code, with: ->(code) { code.strip.upcase }

  scope :controlled_by_users, -> { where.not(user_id: nil) }

  scope :controlled_by_cpu, -> { where(user_id: nil) }

  def not_admin?
    !admin?
  end

  def controlled_by_user?
    user_id.present?
  end
end
