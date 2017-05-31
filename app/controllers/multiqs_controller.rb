class MultiqsController < ApplicationController

  def index
  end

  def new
    @survey = Survey.all.where(:id => params['survey_id'])[0]
    @multiq = MultiQ.new
    @multiqs = MultiQ.all.where(:survey_id => @survey.id)
  end

  def create
    @multiq = MultiQ.new(whitelisted_multiq_params)
    @survey = Survey.find(params[:survey_id])
    n = params[:no_options].to_i
    if @multiq.save
      n.times { @multiq.choices.create(:name => "")}
      flash[:success] = "New Question initiated"
      redirect_to edit_survey_add_question_path(@survey, @multiq)
    else
      flash.now[:danger] = "Couldn't initiate a question"
      render 'new'
    end
  end

  def edit
    @survey = Survey.find(params[:survey_id])
    @multiqs = MultiQ.all.where(:survey_id => params[:survey_id])
    @multiq = MultiQ.find(params[:id])
    @choices = Choice.all.where(:multi_q_id => @multiq.id)
  end

  def update
    @survey = Survey.find(params[:survey_id])
    @multiqs = MultiQ.all.where(:survey_id => params[:survey_id])
    @multiq = MultiQ.find(params[:id])
    @choices = Choice.all.where(:multi_q_id => @multiq.id)
    if @multiq.update(whitelisted_multiq_params)
      flash[:success] = "Updated your account!"
      redirect_to @multiq
    else
      flash.now[:error] = "Failed to update your account!"
      render :edit
    end
  end



  private
  def whitelisted_multiq_params
    params.require(:multi_q).permit(:survey_id, :question, :required, :multiple)
  end


end
