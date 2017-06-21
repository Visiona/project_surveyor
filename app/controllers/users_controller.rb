class UsersController < ApplicationController

  def new
    @survey = Survey.find(params[:survey_id])
    @user = User.new
    if params[:user].nil?
      @survey.multi_qs.each do |q|
        @user.multi_answers.build(:multi_q => q)
      end
    end
    # binding.pry
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @user = User.new(whitelisted_answers_params)
    n = params[:user][:multi_answers_attributes].to_hash.size
    n.times do |i|
      ma_attrs = params[:user][:multi_answers_attributes][i.to_s]
      choices = ma_attrs[:choice_id]
      param_multi_q_id = ma_attrs[:multi_q_id]
      if choices.is_a?(Array) # || choices.nil?
        for_deletion = []
        @user.multi_answers.each do |ma|
          if ma.multi_q_id == param_multi_q_id.to_i
            for_deletion << ma
          end
        end
        for_deletion.each {|ma| ma.destroy}
        # choices.each {|ch| @user.multi_answers.build(:multi_q_id => param_multi_q_id.to_i, :choice_id => ch) }
      else
        puts "Choices are not an array!"
      end
    end

    if @user.save
      flash[:success] = "Thank you for submitting your survey."
      redirect_to root_path
    else
      flash.now[:danger] = "The fields were incorrectly filled out."
      render :new
      # binding.pry
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