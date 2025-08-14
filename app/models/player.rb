class Player < ApplicationRecord
  belongs_to :season

  belongs_to :team, optional: true

  enum :position, { center: 5, power_forward: 4, small_forward: 3, shooting_guard: 2, point_guard: 1 }

  validates :position, presence: true

  validates :code,
    presence: true,
    length: { maximum: 20 },
    uniqueness: { scope: :season_id, allow_blank: true }

  validates :first_name, length: { maximum: 100 }

  validates :last_name, length: { maximum: 100 }

  normalizes :code, with: ->(code) { code.strip.upcase }
end
