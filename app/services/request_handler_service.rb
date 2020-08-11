require 'uri'
require 'net/http'

class RequestHandlerService < ApplicationService
  MEDIA_KEY = {twitter: 'tweet', facebook: 'status', instagram: 'picture'};
  BASE_URL = 'https://takehome.io/'

  attr_accessor :url

  def get_data(media)
    begin
      @url = url_load(media)
      response = response_by(media).read_body
      JSON.parse(response)
    rescue Exception => e
      puts e.message
      []
    end
  end

  def response_by(media)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.request(request)
  end

  def call
    response = {}
    MEDIA_KEY.each do |media_key, res_type|
      res = get_data(media_key.to_s)
      response[media_key] = res.map {|val| val.dig(res_type)}
    end
    response
  end

  def url_load(path)
    URI("https://takehome.io/#{path}")
  end

  def request
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request
  end
end
