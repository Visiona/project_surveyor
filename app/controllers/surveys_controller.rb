class SurveysController < ApplicationController
  layout 'application'

  def index
    @surveys = Survey.all
  end

end
