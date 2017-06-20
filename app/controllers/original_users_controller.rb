




class UsersController < ApplicationController

  def new
    @survey = Survey.find(params[:survey_id])
    @user = User.new
    @user.multi_answers.build
    # binding.pry
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @user = User.new(whitelisted_answers_params)

    if @user.save
      flash[:success] = "Thank you for submitting your survey."
      redirect_to root_path
    else
      flash.now[:danger] = "The fields were incorrectly filled out." + "#{@user.errors.full_messages}"
      @user.multi_answers.build
      render :new
      # binding.pry
    end
  end

  def whitelisted_answers_params
    params.require(:user).permit(
        {:multi_answers_attributes => [:id,
                                      :choice_id,
                                      :user_id,
                                      :multi_q_id,
                                      :_destroy ] } )
  end

end

