class ClientStatus
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def statuses
    client = Client.new(params)
    if client.save
      [200, "#{client.identifier}:#{client.rootUrl}"]
    elsif client.errors.messages[:identifier] == ["has already been taken"]
      [403, client.errors.full_messages.join(", ")]
    else
      [400, client.errors.full_messages.join(", ")]
    end
  end
end
