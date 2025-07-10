class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  around_action :switch_locale

  helper_method :hide_navbar?

  def hide_navbar?
    controller_name == 'users' && action_name == 'new' || controller_name == 'sessions' && action_name == 'new'
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
