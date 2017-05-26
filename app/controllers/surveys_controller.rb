class SurveysController < ApplicationController
  layout 'application'

  def index
    @surveys = Survey.all
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(whitelisted_user_params)
    if @survey.save
      flash[:success] = "New Survey initiated"
      redirect_to root_path #possibly /survey/questions ??
    else
      flash.now[:danger] = "New Survey could not be initiated."
      render 'new'
    end
  end

  private
  def whitelisted_user_params
    params.require(:survey).permit(:title, :description)
  end

end
