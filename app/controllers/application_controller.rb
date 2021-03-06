class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  protected
  def set_locale
    params[:locale] ||= I18n.default_locale
    I18n.locale = params[:locale]
  end
  
  def default_url_options(options={})
    {locale: I18n.locale }
  end
end
