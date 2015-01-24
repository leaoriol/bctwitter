class TweetsController < ApplicationController

	before_action :authenticate_user!
	
	def new
		@tweet = Tweet.new
	end

	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user = current_user
		@tweet.save
		# the flash is a hash --> key and value
		flash.now[:success] = "Tweet Created"
		# render new says to go to a new page instead of default
		render 'new'
	end

	private

	# tweet_params requires that the tweet contains content only
	def tweet_params
		params.require(:tweet).permit(:content)
	end
end
