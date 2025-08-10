class Seasons::BaseController < ApplicationController
  before_action :set_season

  private

  def set_season
    @season = Current.user.seasons.find(params[:season_id])
  end
end
