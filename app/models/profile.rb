class Profile < ActiveRecord::Base
  belongs_to :user

  #picture is the string that we called picture
  #PicUploader is how we called our uploader
  #all of this was asked by us to do in github

  mount_uploader :picture, PicUploader

end
