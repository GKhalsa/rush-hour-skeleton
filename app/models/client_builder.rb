class ClientBuilder
  attr_reader :identifier,
              :current_page,
              :client

  def initialize(identifier)
    @identifier   = identifier
    @current_page = nil
    @client       = Client.find_by(identifier: identifier)
  end

  def build_client
    if client.nil?
      message_to_pass = "Client does not exist"
      [message_to_pass, :error]
    else
      @current_page = "#{identifier}\'s dashboard"
      message_to_pass = message
      [message_to_pass, :index]
    end
  end

  def message
    if client.payload_requests.count == 0
      "no payload data has been received for this source"
    else
      "Welcome to your dashboard"
    end
  end
end
