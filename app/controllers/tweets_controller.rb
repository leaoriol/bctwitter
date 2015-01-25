class TweetsController < ApplicationController

	before_action :authenticate_user!
	
	def new
		@tweet = Tweet.new
		@tweets = current_user.tweets
	end

	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user = current_user

		@tweets = current_user.tweets

		if @tweet.save
			# the flash is a hash --> key and value
			flash.now[:success] = "Tweet Created"
		end
		# render new says to go to a new page instead of default
		render 'new'
	end

	def index
		#this defines a news feed
		@tweets = Tweet.all.reject{ |tweet| tweet.user == current_user}
	end

	private

	# tweet_params requires that the tweet contains content only
	def tweet_params
		params.require(:tweet).permit(:content)
	end
end
