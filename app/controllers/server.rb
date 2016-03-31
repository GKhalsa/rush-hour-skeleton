module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(params[:client])
      if client.save
        status 200
        body "#{client.identifier}:#{client.root_url}"
      elsif client.errors.messages[:identifier] == ["has already been taken"]
        status 403
        body client.errors.full_messages.join(", ")
      else
        status 400
        body client.errors.full_messages.join(", ")
      end
    end

  end
end
