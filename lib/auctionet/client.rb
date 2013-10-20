require 'open-uri'

module Auctionet; end
class Auctionet::Client
  def fetch
    parse perform_request
  end

  private

  def parse raw
    data = JSON.parse raw
    data["items"]
  end

  def perform_request
    open("https://auctionet.com/api/v2/items.json").read
  end
end
