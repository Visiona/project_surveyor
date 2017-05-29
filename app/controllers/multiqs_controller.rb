class MultiqsController < ApplicationController

  def index
  end

  def new
    @survey = Survey.all.where(:id => params['survey_id'])[0]
    @multiq = MultiQ.new(:survey_id => @survey.id)
    @multiqs = MultiQ.all.where(:survey_id => @survey.id)
  end

  def create
    @multiq = MultiQ.new(whitelisted_multiq_params)
    n = params[:no_options].to_i
    n.times { @multiq.choices.build(:name => nil)}
    if @multiq.save
      flash[:success] = "New Question initiated"
      redirect_to edit_survey_add_question_path(@survey, @multiq)
    else
      flash.now[:danger] = "Couldn't initiate a question"
      render 'new'
    end
  end

  def edit
    @survey = Survey.find(params[:id])
    @multiqs = MultiQ.all.where(:survey_id => @survey.id)[0]
    @multiq = MultiQ.new(:survey_id => @survey.id)
    @choices = Choice.all.where(:multiq => @multiq.id)
  end

  def update

  end



  private
  def whitelisted_multiq_params
    params.require(:multiq).permit(:survey_id, :question, :required, :multiple)
  end


end
