class UsersController < ApplicationController

  def new
    @survey = Survey.find(params[:survey_id])
    @user = User.new
    if params[:user].nil?
      @survey.multi_qs.each do |q|
        @user.multi_answers.build(:multi_q => q)
      end
    end
  end

  def create
    @survey = Survey.find(params[:survey_id])
    multi_answers_attrs = params[:user][:multi_answers_attributes]
    @user = User.new
    n = multi_answers_attrs.to_hash.size
    n.times do |i|
      ma_attrs = multi_answers_attrs[i.to_s]
      choices_ids = ma_attrs[:choice_id]
      next if choices_ids.nil?
      param_multi_q_id = ma_attrs[:multi_q_id]
      choices_ids = [choices_ids] unless choices_ids.is_a?(Array)
      choices_ids.each {|ch| @user.multi_answers.build(:multi_q_id => param_multi_q_id.to_i, :choice_id => ch) }
    end
    params[:user][:multi_answers_attributes] = multi_answers_attrs 
    if @user.save
      flash[:success] = "Thank you for submitting your survey."
      redirect_to root_path
    else
      flash.now[:danger] = "The fields were incorrectly filled out."
      render :new
    end
  end

  def whitelisted_answers_params
    params.require(:user).permit(
        {:multi_answers_attributes => [:id,
                                      :choice_id,
                                      { :choice_id => [] },
                                      :user_id,
                                      :multi_q_id,
                                      :_destroy ] } )
  end

end