class ProfilesController < ApplicationController
  #belongs_to :user

  def new
  	@profile = Profile.new
  end 

  def create
  	@profile = Profile.new(profile_params)
  	@profile.user = current_user
  	if @profile.save
  		flash[:success] = "Profile Created!"
  		redirect_to profile_path
  	else
  		flash[:error] = "Please try again"
  		render 'new'
  	end
  end

  private
  def profile_params
  	params.require(:profile).permit(:picture)
  end
end