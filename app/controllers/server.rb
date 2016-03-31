module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(params[:client])
      if client.save == true
        status 200
        body "#{client.identifier}:#{client.root_url}"
      elsif client.errors.include?(:identifer)
        status 403
        body client.errors.full_message.join
      else
        binding.pry
        status 400
        body client.errors.full_message.join(", ")
      end
    end

  end
end
