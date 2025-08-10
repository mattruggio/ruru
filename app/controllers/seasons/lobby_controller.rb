class Seasons::LobbyController < Seasons::BaseController
  before_action :ensure_state

  def show
  end

  private

  def ensure_state
    return if @season.waiting_for_users?

    redirect_to @season
  end
end
