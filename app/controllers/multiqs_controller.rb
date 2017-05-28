class MultiqsController < ApplicationController

  def index
    # @survey = Survey.all.where(:id => params['survey_id'])[0]
    # @multiqs = MultiQ.all.where(:survey_id => @survey.id)
  end

  def new
    @multiq = MultiQ.new
  end

  def create
    @multiq = MultiQ.new(whitelisted_multiq_params)
    if @multianswer.present?
      if @multiq.save
        flash[:success] = "New Question created"
        redirect_to survey_add_questions
      else
        flash.now[:danger] = "Couldn't create a question"
        render 'new'
      end
    else
      @multianswer = MultiAnswer.new
      render 'new'
    end
  end



  private
  def whitelisted_multiq_params
    params.require(:multiq).permit(:survey_id, :question)
  end


end
