class LocateSeasonFormsController < ApplicationController
  def new
    @locate_season_form = LocateSeasonForm.new
  end

  def create
    @locate_season_form = LocateSeasonForm.new(locate_season_form_params)

    if @locate_season_form.save
      redirect_to new_join_season_form_path(join_code: @locate_season_form.join_code)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def locate_season_form_params
    params.require(:locate_season_form).permit(:join_code)
  end
end
