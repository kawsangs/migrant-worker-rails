class InstitutionsController < ApplicationController
  def index
  end

  def new
    @institution = Institution.new
  end
end
