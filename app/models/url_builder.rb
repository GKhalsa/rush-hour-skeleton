class UrlBuilder
  attr_reader :identifier,
              :relative_path,
              :url_message,
              :url,
              :url_address

  def initialize(identifier, relative_path)
    @identifier    = identifier
    @relative_path = relative_path
    client         = Client.where(identifier: identifier).first
    @url_address   = client.rootUrl + "/" + relative_path
    @url           = Url.find_or_create_by(address: url_address)
    @url_message   = message(url)
  end

  def current_page
    "stats for #{url_address}"
  end

  def message(url)
    if url.payload_requests == []
      "this url has not been requested"
    else
      "your page is kicking ass"
    end
  end
end
