class VisitorsController < ApplicationController

  def index
    @blogs = Scrapper.fetch!
  end
end
