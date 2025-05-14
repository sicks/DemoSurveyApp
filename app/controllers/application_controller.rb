class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordInvalid do |e|
    respond_to do |format|
      format.turbo_stream do
        flash.now[:error] = e.message
        render :error
      end
    end
  end
end
