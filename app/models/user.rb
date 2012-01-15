class User
  include MongoMapper::Document
    key :name, String
    key :email, String
    key :uid, Integer
    key :nickname, String
    key :access_token, String 
    
    attr_accessible :name, :email, :nickname, :uid, :access_token
    def self.create_with_omniauth(auth)
      @user = User.create!(:name => auth["info"]["name"], :email => auth["info"]['email'], :uid => auth['uid'], :access_token => auth["credentials"]["token"], :nickname => auth["info"]["nickname"])
      @user.save!
      @user
    end
end
