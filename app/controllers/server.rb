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
      builder        = ClientBuilder.new(identifier)
      @client        = builder.client
      @message, view = builder.build_client
      @current_page  = builder.current_page
      erb view
    end

    post '/sources' do
      cs = ClientStatus.new(params)
      status_code, body_content = cs.statuses
      status  status_code
      body body_content
    end

    get '/sources/:IDENTIFIER/urls/:RELATIVEPATH' do |identifier, relative_path|
      url_builder   = UrlBuilder.new(identifier, relative_path)
      @url          = url_builder.url
      @current_page = url_builder.current_page
      @url_message  = url_builder.url_message
      erb :show_url
    end

    post '/sources/:IDENTIFIER/data' do |identifier|
      payload_request = PayloadBuilder.new(params)
      status payload_request.status_id
      body   payload_request.body
    end

    get '/sources/:IDENTIFIER/events/:EVENTNAME' do |identifier, event_name|
      event_builder   = EventBuilder.new(identifier, event_name)
      @event_type     = event_builder.event_type
      @event_message  = event_builder.event_message
      @event_per_hour = event_builder.event_per_hour
      @current_page   = event_builder.current_page
      erb :event_hours
    end
  end
end
