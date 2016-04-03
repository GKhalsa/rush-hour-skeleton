class ClientBuilder
  attr_reader :identifier,
              :message,
              :current_page,
              :client

  def initialize(identifier)
    @identifier   = identifier
    @message      = nil
    @current_page = nil
    @client       = Client.find_by(identifier: identifier)
  end

  def build_client
    if client.nil?
      @message = "Client does not exist"
      [@message, :error]
    else
      @current_page = "#{identifier}\'s dashboard"
      @message = message
      [@message, :index]
    end
  end

  def message
    if client.payload_requests.count == 0
      message = "no payload data has been received for this source"
    else
      message = "Welcome to your dashboard"
    end
  end
end
