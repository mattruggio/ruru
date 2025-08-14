class JoinSeasonFormsController < ApplicationController
  before_action :set_season_from_join_code

  def new
  end

  def create
    @season.join!(Current.user, params[:team_code])

    render turbo_stream: turbo_stream.action(:redirect, season_path(@season))
  end

  private

  def set_season_from_join_code
    @season = Season.find_by(join_code: params[:join_code])

    redirect_to root_path, alert: "Join code is not valid or the season is not joinable" unless @season&.joinable?
  end
end
