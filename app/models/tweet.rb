class Tweet < ActiveRecord::Base

	include Twitter::Extractor

	belongs_to :user
	validates :content, length: { maximum: 140}

	def extract_hash_tags
		extract_hashtags(self.content)
	end

	#whenever create new tweet, will call hashtags_created
	validate :hashtags_created

	def hashtags_created 
		begin
		transaction do
			@hashtags = self.extract_hash_tags

			@hashtags.each do |the_hashtag|
				if Hashtag.where(tag: the_hashtag).any?
				#do nothing
				else
					if Hashtag.create(tag: the_hashtag)
					else
						self.errors.add(:tweet, "The hashtag is invalid")
					end
				end
			end
		end
		rescue
			self.errors.add(:tweet, "The hashtag(s) are invalid.")
		end
	end
end
