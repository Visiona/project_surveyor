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
    @multiqs = MultiQ.all.where(:survey_id => params[:survey_id])
    @multiq = MultiQ.find(params[:id])
    (params[:no_options].to_i).times { @multiq.choices.build}
  end

  def update
    @survey = Survey.find(params[:survey_id])
    @multiqs = @survey.multi_qs
    @multiq = MultiQ.find(params[:id])
    @choices = @multiq.choices
    if @multiq.update(whitelisted_multiq_params)
      flash[:success] = "Updated your account!"
      redirect_to edit_survey_path(@survey)
    else
      flash.now[:error] = "Failed to update your account!" + @order.errors.full_messages.join(', ')
      render :edit
    end
  end


  def destroy
    # @order = Order.find(params[:id])
    # take_user = @order.user_id
    # if @order.destroy
    #   flash[:success] = "Order deleted successfully!"
    #   redirect_to admin_orders_path, :locals => {:user_id => take_user }
    # else
    #   flash[:danger] = "Failed to delete the address"
    #   redirect_to :back
    # end
  end



  private
  def whitelisted_multiq_params
    params.require(:multi_q).permit(:survey_id, :question, :required, :multiple, :choices_attributes => [:name, :multi_q_id, :id, :_destroy ])
  end


  # def no_of_answers=(no_options)
  #   @number = no_options
  # end

  # def no_of_answers
  #   @number
  # end

end
