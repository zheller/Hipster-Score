class Artist
  include MongoMapper::Document
    key :name, String
    key :hipster, Boolean
    
    ensure_index :name, :unique => true
    
    attr_accessible :name, :hipster
    
    # need to take out initial the 
    # need to take out any special characters such as & ( )
    
    def self.initilize_db
      File.open("#{Rails.root.to_s}/lib/billboard/billboard-artists.txt", 'r') do |file|
        x = []
        file.each do |line| 
          x << line
        end
        x = x.uniq
        x.each do |artist|
          artistfix = artist.lstrip.rstrip.downcase!
          Artist.create!(:name => artistfix, :hipster => false)
        end
      end
      
      File.open("#{Rails.root.to_s}/lib/pitchfork-scraper/pitchfork-artists.txt", 'r') do |file|
        x = []
        file.each do |line| 
          x << line
        end
        x = x.uniq
        x.each do |artist|
          artistfix = artist.lstrip.rstrip.downcase!
          Artist.create!(:name => artistfix, :hipster => true)
        end
      end
    end
    
end
