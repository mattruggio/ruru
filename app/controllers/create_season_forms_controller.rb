class CreateSeasonFormsController < ApplicationController
  def new
    @create_season_form = CreateSeasonForm.new(user: Current.user)
  end

  def create
    @create_season_form = CreateSeasonForm.new(create_season_form_params.merge(user: Current.user))

    if @create_season_form.save
      redirect_to @create_season_form.season
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_season_form_params
    params.require(:create_season_form).permit(:team_code)
  end
end
