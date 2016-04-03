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

    get '/sources/:identifier' do |identifier|
      if Client.where(identifier: identifier) == []
        @message = "Client does not exist"
        erb :error
      else
        @current_page = "#{identifier}\'s dashboard"
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

    get '/sources/:IDENTIFIER/urls/:RELATIVEPATH' do |identifier, relative_path|
      client = Client.where(identifier: identifier).first
      url_address = client.rootUrl + "/" + relative_path
      # binding.pry
      @url = Url.find_or_create_by(address: url_address)
      # @url = Url.where(address: url_address).first
      @current_page = "stats for #{url_address}"
      @url_message = url_message(@url)
      erb :show_url
    end

    post '/sources/:IDENTIFIER/data' do |identifier|
      payload_request = PayloadBuilder.new(params)

      status payload_request.status_id
      body   payload_request.body
    end

    def url_message(url)
      if url.payload_requests == []
        "this url has not been requested"
      else
        "your page is kicking ass"
      end
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
