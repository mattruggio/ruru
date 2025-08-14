class Seasons::PlayersController < Seasons::BaseController
  def index
    @players = paginate(@season.players.order(:last_name, :first_name))
  end
end
