class JoinSeasonChannel < Turbo::StreamsChannel
  def subscribed
    if authorized?
      stream_from stream_name
    else
      reject
    end
  end

  private

  def stream_name
    @stream_name ||= verified_stream_name_from_params
  end

  def authorized?
    season.joinable?
  end

  def season
    gid = stream_name.split(":").first

    @season ||= GlobalID::Locator.locate(gid)
  end
end
