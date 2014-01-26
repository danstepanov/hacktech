require 'rubygems'
require 'net/http'
require 'JSON'

class Whisper
  
  def nearby(params)
    call = '/whispers/nearby/distance'
    
    params[:include_topics] = TRUE unless params.key?(:include_topics)
    
    API.query(call, params)['nearby']
  end
  
  def popular(params)
    call = '/whispers/popular/popular'
    
    params[:include_topics] = TRUE unless params.key?(:include_topics)
    
    API.query(call, params)['popular']
  end
  
  def featured(params)
    call = '/whispers/popular/all_time'
    
    params[:include_topics] = TRUE unless params.key?(:include_topics)
    
    API.query(call, params)['popular']
  end
  
  def suggest(params)
    call = '/search/suggest/' + options[:text]
    params.except!(:text)
    
    params[:type] = 'place' unless params.key?(:type)
    
    API.query(call, params)
  end
  
  def find(params)
    call = '/feed/whispers'
    
    API.query(call, params)
  end
  
  class API
    def self.query(call, params)
      @api = 'https://hackproxy.whisper.sh'
      uri = URI(@api + call)
      uri.query = URI.encode_www_form(params)
      
      raw = Net::HTTP.get_response(uri)
      
      JSON.parse(raw.body) # return
    end
  end
end

# TESTING

# whis = Whisper.new
# results = whis.nearby :lat => 34.0219, :lon => -118.4814
# 
# results.each do |whisper|
#   puts "{"
#   
#   whisper.each do |key, value|
#     puts "\t #{key} : #{value}"
#   end
#   
#   puts "}"
# end
