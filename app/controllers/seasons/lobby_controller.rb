class Seasons::LobbyController < Seasons::BaseController
  def show
    @teams = @season.teams.order(:code)
  end
end
