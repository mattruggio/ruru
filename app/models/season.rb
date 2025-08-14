class Season < ApplicationRecord
  include WorkflowActiverecord

  class NotJoinableError < StandardError; end

  workflow do
    state :waiting_for_users do
       event :begin_draft, transitions_to: :draft_in_progress
    end
    state :draft_in_progress

    after_transition do |from_state, to_state, event|
      if to_state == :draft_in_progress
        broadcast_draft_began
      end
    end
  end


  has_many :teams, dependent: :destroy

  has_many :players, dependent: :destroy

  before_create :assign_join_code

  validates :join_code, uniqueness: { allow_nil: true }, length: { maximum: 64 }

  after_create :load_teams, :load_players

  def join!(user, team_code)
    raise NotJoinableError unless joinable?

    team = teams.controlled_by_cpu.find_by(code: team_code)

    team.update!(user:)

    # broadcast_render_later_to
    broadcast_render_to(
      self,
      partial: "seasons/user_joined",
      formats: %i[turbo_stream],
      locals: { season: self, team: }
    )
  end

  def name
    persisted? ? "Season ##{id}" : "New Season"
  end

  def begin_draft
    teams.shuffle.each_with_index do |team, index|
      team.update!(draft_position: index)
    end
  end

  def broadcast_draft_began
    # broadcast_render_later_to
    broadcast_render_to(
      self,
      partial: "seasons/draft_began",
      formats: %i[turbo_stream],
      locals: { season: self }
    )
  end

  def admin?(user)
    teams.select { |t| t.user_id == user.id && t.admin? }.any?
  end

  def team_for_user(user)
    teams.find_by(user:)
  end

  def user?(user)
    teams.where(user:).any?
  end

  def joinable?
    waiting_for_users?
  end

  private

  def assign_join_code
    self.join_code = SecureRandom.hex(10)
  end

  def load_players
    players_by_code = Store.players_by_code(2005)

    players_to_load = players_by_code.map do |code, player_data|
      position = case player_data["position"]
      when "C" then 5
      when "PF" then 4
      when "SF" then 3
      when "SG" then 2
      when "PG" then 1
      else
        raise "Unknown position: #{player_data['position']}"
      end

      {
        season_id: id,
        code: code.strip.upcase,
        first_name: player_data["first_name"],
        last_name: player_data["last_name"],
        position:,
        overall: player_data["abilities"]["overall"]
      }
    end

    Player.insert_all!(players_to_load)
  end

  def load_teams
    teams_by_code = Store.teams_by_code

    teams_to_load = teams_by_code.map do |code, team_data|
      {
        season_id: id,
        code: code.strip.upcase,
        location: team_data["location"],
        name: team_data["name"]
      }
    end

    Team.insert_all!(teams_to_load)
  end
end
