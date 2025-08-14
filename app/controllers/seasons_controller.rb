class SeasonsController < ApplicationController
  before_action :set_season, only: %i[show begin_draft]

  def new
  end

  def create
    ActiveRecord::Base.transaction do
      @season = Season.create!
      @season.teams.find_by(code: params[:team_code]).update!(user: Current.user, admin: true)
    end

    redirect_to @season
  end

  def begin_draft
    @season.begin_draft!

    render turbo_stream: turbo_stream.action(:redirect, season_draft_logs_path(@season))
  end

  def index
    @seasons = Current.user.seasons.order(created_at: :desc).includes(:teams)
  end

  def show
    if @season.waiting_for_users?
      redirect_to [ @season, :teams ]
    elsif @season.draft_in_progress?
      redirect_to [ @season, :draft_logs ]
    else
      redirect_to root_path, alert: "Season is in an unknown state."
    end
  end

  private

  def set_season
    @season = Current.user.seasons.find(params[:id])
  end
end
