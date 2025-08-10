class ValidateJoinCodeFormsController < ApplicationController
  def new
    @validate_join_code_form = ValidateJoinCodeForm.new
  end

  def create
    @validate_join_code_form = ValidateJoinCodeForm.new(validate_join_code_form_params)

    if @validate_join_code_form.valid?
      redirect_to new_join_season_form_path(join_code: @validate_join_code_form.join_code)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def validate_join_code_form_params
    params.require(:validate_join_code_form).permit(:join_code)
  end
end
