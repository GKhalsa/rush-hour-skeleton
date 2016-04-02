module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    get '/errors' do
      status 400
      erb :error
    end

    get '/' do
      @current_page = "Welcome!"
      erb :welcome
    end

    get '/index' do
      erb :index
    end

    # get '/sources/:identifier' do |identifier|
    #   @client = Client.where(identifier: identifier).first
    #   binding.pry
    #   if @client.payload_requests.empty?
    #     erb :message
    #   else
    #     @current_page = ":dashboard"
    #     @message      = message
    #     erb :index
    #   end
    # end

    get '/sources/:identifier' do |identifier|
      if Client.where(identifier: identifier) == []
        @message = "Client does not exist"
        erb :error
      else
        @client = Client.where(identifier: identifier).first
        @message = message
        erb :index
      end
    end

    post '/sources' do
      @client = Client.new(params)
      if @client.save
        status 200
        body  "#{@client.identifier}:#{@client.rootUrl}"
        #{redirect "/sources/#{@client.identifier}"}
      elsif @client.errors.messages[:identifier] == ["has already been taken"]
        body @client.errors.full_messages.join(", ")
        # redirect '/errors'
        status 403
      else
        body @client.errors.full_messages.join(", ")
        # redirect '/errors'
        status 400
      end
    end

    post '/sources/:IDENTIFIER/data' do |identifier|
      payload_request = PayloadBuilder.new(params)

      status payload_request.status_id
      body   payload_request.body
    end

    def message
      if @client.payload_requests.count == 0
        message = "no payload data has been received for this source"
      else
        message = "Welcome to your dashboard"
      end
    end
  end
end
