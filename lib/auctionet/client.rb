require 'open-uri'

module Auctionet; end
class Auctionet::Client
  def fetch
    data = JSON.parse perform_request
    data["items"]
  end

  def fetch_item id
    data = JSON.parse perform_request id
    data["item"]
  end

  private

  def perform_request(param = nil)
    suffix = if param
               "items/#{param}.json"
             else
               "items.json"
             end
    open("https://auctionet.com/api/v2/" + suffix).read
  end
end
