require 'rubygems'
require 'mechanize'

agent = Mechanize.new
629.times do |n|
  artists = agent.get("http://pitchfork.com/reviews/albums/#{n + 1}/").search('div.review a strong')
  artists.each do |artist|
    open('pitchfork-artists.txt', 'a') do |f|
      f << artist.content + "\n"
    end
  end
end