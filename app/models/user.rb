class User
  include MongoMapper::Document
    key :name, String
    key :email, String
    key :uid, Integer
    key :nickname, String
    key :access_token, String
    key :artists, Array
    
    attr_accessible :name, :email, :nickname, :uid, :access_token
    
    def self.create_with_omniauth(auth)
      @user = User.create!(:name => auth["info"]["name"], :email => auth["info"]['email'], :uid => auth['uid'], :access_token => auth["credentials"]["token"], :nickname => auth["info"]["nickname"])
      @user.save_music()
    end
    
    def self.find_artists(user)
      if user.access_token?
        
      end
   
   def save_music()
      raw_music = HTTParty.get("https://graph.facebook.com/#{self.uid}/music?access_token=#{self.access_token}")
      music = ActiveSupport::JSON.decode(raw_music.body)
      # iterate over artists and save to db
      music['data'].each do |artist|
        self.add_to_set(:artists => artist['name'])
      end
    end
    
end
