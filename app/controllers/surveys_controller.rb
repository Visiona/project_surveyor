class SurveysController < ApplicationController
  layout 'application'

  def index
    @surveys = Survey.all
  end

  def new
    @survey = Survey.new
  end

  def show
    @survey = Survey.find(params[:id])
    @multiqs = MultiQ.all.where(:survey_id => @survey.id)
  end

  def create
    @survey = Survey.new(whitelisted_user_params)
    if @survey.save
      flash[:success] = "New Survey initiated"
      redirect_to new_survey_add_question_path(@survey)
    else
      flash.now[:danger] = "New Survey could not be initiated."
      render 'new'
    end
  end

  def edit
    @survey = Survey.find(params[:id])
    @multiqs = MultiQ.all.where(:survey_id => @survey.id)
  end

  def update

  end

  private
  def whitelisted_user_params
    params.require(:survey).permit(:title, :description)
  end

end
