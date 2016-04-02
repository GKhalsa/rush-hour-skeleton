module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(params)
      if client.save
        [200, "#{client.identifier}:#{client.root_url}"]
      elsif client.errors.messages[:identifier] == ["has already been taken"]
        status 403
        body client.errors.full_messages.join(", ")
      else
        status 400
        body client.errors.full_messages.join(", ")
      end
    end

    post '/sources/:IDENTIFIER/data' do |identifier|
      payload_request = PayloadBuilder.new(params)

      status payload_request.status_id
      body   payload_request.body
    end


  end
end
