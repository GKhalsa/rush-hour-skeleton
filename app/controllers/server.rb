module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

#     get '/robots/new' do
#   @current_page = "create"
#   erb :new
# end
#
# post '/robots' do
#   robot_wrangler.create(params[:robot])
#   redirect '/robots'
# end
#
# get '/robots/:id' do |id|
#   @robot = robot_wrangler.find(id.to_i)
#   @current_page = "about #{@robot.name}"
#   erb :show
# end
#
# get '/robots/:id/edit' do |id|
#  @current_page = "edit"
#  @robot = robot_wrangler.find(id.to_i)
#  erb :edit
# end


    get '/' do
      @current_page = "Welcome!"
      erb :welcome
    end

    get '/index' do
      erb :index
    end

    get '/sources/:identifier' do |identifier|
      @client = Client.where(identifier: identifier)
      @current_page = ":dashboard"
      erb :index
    end

    post '/sources' do
      client = Client.new(params)

      # if status == 403
      #   body client.errors.full_messages.join(", ")
      #   # redirect '/errors'
      # elsif status == 400
      #   body client.errors.full_messages.join(", ")
      #   # redirect '/errors'
      # elsif status == 200
      #   client.save
      #   [200, "#{client.identifier}:#{client.root_url}"]
      #   # redirect "/sources/#{client.identifier}"
      # end

      if client.save
        status 200
        body  "#{client.identifier}:#{client.root_url}"
        # binding.pry
        # redirect "/sources/#{client.identifier}"
      elsif client.errors.messages[:identifier] == ["has already been taken"]
        status 403
        body client.errors.full_messages.join(", ")
        # redirect '/errors'
      else
        status 400
        body client.errors.full_messages.join(", ")
        # redirect '/errors'
      end
    end

    post '/sources/:IDENTIFIER/data' do |identifier|
      payload_request = PayloadBuilder.new(params)

      status payload_request.status_id
      body   payload_request.body
    end

  end
end
