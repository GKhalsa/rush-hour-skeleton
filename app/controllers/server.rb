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
        builder = ClientBuilder.new(identifier)
        @client = builder.client
        @message, view = builder.build_client
        @current_page = builder.current_page
        erb view
      end

      post '/sources' do
        cs = ClientStatus.new(params)
        status_code, body_content = cs.statuses
        status  status_code
        body body_content
      end

      get '/sources/:IDENTIFIER/urls/:RELATIVEPATH' do |identifier, relative_path|
        url_builder = UrlBuilder.new(identifier, relative_path)

        @url = url_builder.url
        @current_page = url_builder.current_page
        @url_message = url_builder.url_message
        erb :show_url

      end

      post '/sources/:IDENTIFIER/data' do |identifier|
        payload_request = PayloadBuilder.new(params)

        status payload_request.status_id
        body   payload_request.body
      end

      get '/sources/:IDENTIFIER/events/:EVENTNAME' do |identifier, event_name|
        client = Client.where(identifier: identifier).first
        @event_type = EventType.find_or_create_by(name: event_name)
        @event_message = event_message(@event_type)
        @event_per_hour = @event_type.by_hours
        @current_page   = "#{event_name}"

        erb :event_hours
      end

    # def url_message(url)
    #   if url.payload_requests == []
    #     "this url has not been requested"
    #   else
    #     "your page is kicking ass"
    #   end
    # end

    def event_message(event)
      if event.payload_requests == []
        "This event hasn't been requested"
      else
        "your event is kicking ass"
      end
    end

  end
end
