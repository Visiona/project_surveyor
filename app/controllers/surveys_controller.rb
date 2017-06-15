class SurveysController < ApplicationController
  layout 'application'

  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.includes(multi_qs: :choices).find(params[:id])
    # !!!! REMEMBER IT!!!!!!
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(whitelisted_survey_params)
    if @survey.save
      flash[:success] = "New Survey initiated"
      redirect_to edit_survey_path(@survey.id)
    else
      flash.now[:danger] = "New Survey could not be initiated."
      render 'new'
    end
  end

  def edit
    @survey = Survey.find(params[:id])
    @choice_type ||= params[:choice_type]
    @multiqs = @survey.multi_qs.includes(:choices)
    @mutiq = MultiQ.new
  end

  def update
    if params[:choice_type] == "Multiple Choice"
      flash.now[:success] = "Initiated Multiple Choice Question"
      redirect_to new_survey_add_question_path(params[:id])
    elsif params[:choice_type] == "Number Range"
      flash.now[:success] = "Initiated Number Range Question, however this option is not ready yet and you are transferred to Multiple Choice Question instead. Sorry."
      redirect_to new_survey_add_question_path(@survey)
    else
      flash[:danger] = "We couldn't create any Question" + @survey.errors.full_messages.join(', ')
      render 'edit', :locals => {:survey => @survey}
    end
  end

  private
  def whitelisted_survey_params
    params.require(:survey).permit(:title, :description)
  end

end
