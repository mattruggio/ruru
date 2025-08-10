class SeasonsController < ApplicationController
  before_action :set_season, only: :show

  def index
    @seasons = Current.user.seasons.order(created_at: :desc)
  end

  def show
    if @season.waiting_for_users?
      redirect_to [ @season, :lobby ]
    else
      redirect_to root_path, alert: "Season is in an unknown state."
    end
  end

  private

  def set_season
    @season = Current.user.seasons.find(params[:id])
  end
end
