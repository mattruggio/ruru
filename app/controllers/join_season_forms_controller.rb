class JoinSeasonFormsController < ApplicationController
  before_action :set_season_from_join_code

  def new
    @join_season_form = JoinSeasonForm.new(user: Current.user, season: @season)
  end

  def create
    @join_season_form = JoinSeasonForm.new(join_season_form_params.merge(user: Current.user, season: @season))

    if @join_season_form.save
      redirect_to @season
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_season_from_join_code
    @season = Season.find_by(join_code: params[:join_code])
  end

  def join_season_form_params
    params.require(:join_season_form).permit(:team_code)
  end
end
