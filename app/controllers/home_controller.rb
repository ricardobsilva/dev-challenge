class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @mainTitle = "d"
    @mainDesc = "d"
  end

  def minor
  end
end
