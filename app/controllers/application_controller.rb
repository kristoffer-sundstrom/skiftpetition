class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :globals

  def globals
    @clubs = Registration.clubs
  end

end
