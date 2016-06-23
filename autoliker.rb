require 'rubygems'
require 'instagram'
# configure instagram gem, get token by registering app and following client-side authentication on http://instagram.com/developer/
Instagram.configure do |config|
  config.access_token = "3193763015.966ce18.281b03067753463fb2739733849d64b9"
  config.client_id = "966ce18412bc46e3b1986200d1d99b71"
  end
# define tags to grab pictures to like from
selected_tags = %w(
                 centralpark
)
# loop through each tag
selected_tags.each do |tag|

  #get 60 most recent photos from tag
  photos = Instagram.tag_recent_media(tag, {count: 60})

  error_count = 0

  photos.each do |photo|

    # like each photo
    puts "starting liking #{tag} - #{photo.id}"
    begin
      Instagram.like_media(photo.id)
      puts "completed liking #{photo.id}"
    rescue Exception => e
      error_count = error_count + 1
      puts e.message
      if error_count%2 == 0
        puts 'Error! Retry has failed, waiting 10 min'
        sleep 600
      end
    end
  end
end
