class UsersController < ApplicationController

  def new
    @survey = Survey.find(params[:survey_id])
    @user = User.new
    @survey.multi_qs.each do |q|
      @user.multi_answers.build(:multi_q => q)
    end
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @user = User.new(whitelisted_answers_params)
    if @user.save
      # @multi_answers.where(:choice_id => nil).destroy_all
      flash[:success] = "Thank you for submitting your survey."
      redirect_to root_path
    else
      flash.now[:danger] = "The fields were incorrectly filled out."
      render 'new'
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
