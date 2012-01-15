require 'json'
require 'net/http'

# http://api.billboard.com/apisvc/chart/v1/list?format=json&sdate=2000-03-01&edate=2001-04-01

def search_billboard(sdate, edate)
   base_url = "http://api.billboard.com/apisvc/chart/v1/list?format=json&api_key=bvk4re5h37dzvx87h7rf5dqz"
   url = "#{base_url}&sdate=#{sdate}&edate=#{edate}"
   resp = Net::HTTP.get_response(URI.parse(url))
   data = resp.body

   # we convert the returned JSON data to native Ruby
   # data structure - a hash
   result = JSON.parse(data)

   # if the hash has 'Error' as a key, we raise an error
   if result.has_key? 'Error'
      raise "web service error"
   end
   return result
end

searches = [
  #{:sdate => '2000-01-01', :edate => '2000-06-30'},
  #{:sdate => '2000-07-01', :edate => '2000-12-30'},
  #{:sdate => '2001-01-01', :edate => '2001-06-30'},
  #{:sdate => '2001-07-01', :edate => '2001-12-30'},
  #{:sdate => '2002-01-01', :edate => '2002-06-30'},
  #{:sdate => '2002-07-01', :edate => '2002-12-30'},
  #{:sdate => '2003-01-01', :edate => '2003-06-30'},
  #{:sdate => '2003-07-01', :edate => '2003-12-30'},
  #{:sdate => '2004-01-01', :edate => '2004-06-30'},
  #{:sdate => '2004-07-01', :edate => '2004-12-30'},
  #{:sdate => '2005-01-01', :edate => '2005-06-30'},
  #{:sdate => '2005-07-01', :edate => '2005-12-30'},
  {:sdate => '2006-01-01', :edate => '2006-06-30'},
  {:sdate => '2006-07-01', :edate => '2006-12-30'},
  {:sdate => '2007-01-01', :edate => '2007-06-30'},
  {:sdate => '2007-07-01', :edate => '2007-12-30'},
  {:sdate => '2008-01-01', :edate => '2008-06-30'},
  {:sdate => '2008-07-01', :edate => '2008-12-30'},
  {:sdate => '2009-01-01', :edate => '2009-06-30'},
  {:sdate => '2009-07-01', :edate => '2009-12-30'},
  {:sdate => '2010-01-01', :edate => '2010-06-30'},
  {:sdate => '2010-07-01', :edate => '2010-12-30'},
  {:sdate => '2011-01-01', :edate => '2011-06-30'},
  {:sdate => '2011-07-01', :edate => '2011-12-30'}
]

searches.each do |s|
  result = search_billboard(s[:sdate], s[:edate])

  result['searchResults']['chartItem'].each do |i|
    artist = i['artist']
    if artist
      puts "Got Artist: " + artist
      open('billboard-artists.txt', 'a') do |f|
        f << artist + "\n"
      end
    end
  end
end

