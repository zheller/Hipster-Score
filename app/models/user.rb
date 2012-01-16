class User
  include MongoMapper::Document
    key :name, String
    key :email, String
    key :uid, Integer
    key :nickname, String
    key :access_token, String
    key :artists, Array
    key :score
    
    attr_accessible :name, :email, :nickname, :uid, :access_token
    
    ensure_index :email
    
    def self.create_with_omniauth(auth)
      @user = User.create!(:name => auth["info"]["name"], :email => auth["info"]['email'], :uid => auth['uid'], :access_token => auth["credentials"]["token"], :nickname => auth["info"]["nickname"])
      @user.save_music()
    end
    
   
   def save_music
      raw_music = HTTParty.get("https://graph.facebook.com/#{self.uid}/music?access_token=#{self.access_token}")
      music = ActiveSupport::JSON.decode(raw_music.body)
      # iterate over artists and save to db
      music['data'].each do |artist|
        fix = artist['name'].lstrip.rstrip.downcase!
        self.add_to_set(:artists => fix)
      end
    end
  
  def calc_score
    time_start = Time.now
    base_score = 50
    delta = 50 / self.artists.count.to_f
    
    self.artists.each do |artist|
      @test_artist = Artist.find_by_name(artist)
      if @test_artist
        if @test_artist.hipster?
          base_score += delta
        else
          base_score -= delta
        end
      else
        base_score
      end
    end
    time_stop = Time.now
    puts (time_stop - time_start) * 1000
    puts base_score
  end
  
  
end
