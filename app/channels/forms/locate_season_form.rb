class LocateSeasonForm < ApplicationForm
  attribute :join_code, :string

  validates :join_code, presence: true

  validate :join_code_is_joinable

  private

  def join_code_is_joinable
    return if Season.exists?(join_code:)

    errors.add(:join_code, "is not valid or the season is not joinable")
  end
end
