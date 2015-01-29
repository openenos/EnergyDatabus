require 'yaml'
require 'net/http'

module ApplicationHelper
  include SiteGroupsHelper
  
  def getBaseURL
    url_file = YAML.load_file('config/ws_url.yml')
    return url_file["#{Rails.env}"]["url"]   
  end
  
  def jsonResponse url
      if url.include?('?')
        url = "#{url}&#{apiToken}"
        else 
        url = "#{url}?#{apiToken}"
      end
      resp = Net::HTTP.get_response(URI.parse(url))
      return JSON.parse(resp.body)
  end

  def apiToken
     return "access_token=6ee462a0b32847e6159d9ae075a21e7f"
  end

end