class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def paginate(collection, default_per_page: 30)
    page = params[:page]
    per_page = params[:per_page] || default_per_page

    collection.paginate(page:, per_page:)
  end
end
