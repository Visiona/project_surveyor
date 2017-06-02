class MultiqsController < ApplicationController


  def new
    @survey = Survey.all.where(:id => params['survey_id'])[0]
    @survey.multi_qs.each {|obj| obj.destroy if obj.question.empty?}
    @survey.multi_qs.each do |obj|
      obj.choices.each {|choice_obj| choice_obj.destroy if choice_obj.name.empty?}
    end
    @multiq = MultiQ.new
    @multiqs = MultiQ.all.where(:survey_id => @survey.id)
  end

  def create
    @multiq = MultiQ.new(whitelisted_multiq_params)
    @survey = Survey.find(params[:survey_id])
    if @multiq.save
      flash[:success] = "New Question initiated"
      redirect_to edit_survey_add_question_path(@survey, @multiq, no_options: params[:no_options])
    else
      flash.now[:danger] = "Couldn't initiate a question"
      render 'new'
    end
  end

  def edit
    @survey = Survey.find(params[:survey_id])
    @multiqs = @survey.multi_qs.includes(:choices)
    @multiq = MultiQ.find(params[:id])
    (params[:no_options].to_i).times { @multiq.choices.build}
  end

  def update
    @survey = Survey.find(params[:survey_id])
    @multiqs = @survey.multi_qs.includes(:choices)
    @multiq = MultiQ.find(params[:id])
    if @multiq.update(whitelisted_multiq_params)
      flash[:success] = "Updated your question with choices!"
      redirect_to edit_survey_path(@survey)
    else
      flash.now[:error] = "Failed to update your question!" + @multiq.errors.full_messages.join(', ')
      render :edit
    end
  end


  def destroy
    @multiq = MultiQ.find(params[:id])
    @survey = Survey.find(params[:survey_id])
    if @multiq.destroy
      flash[:success] = "Question deleted successfully!"
      redirect_to new_survey_add_question_path
    else
      flash[:danger] = "Failed to delete the question"
      redirect_to :back
    end
  end


  private
  def whitelisted_multiq_params
    params.require(:multi_q).permit(:survey_id, :question, :required, :multiple, :choices_attributes => [:name, :multi_q_id, :id, :_destroy ])
  end


end
