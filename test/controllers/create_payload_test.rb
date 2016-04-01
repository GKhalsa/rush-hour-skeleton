require_relative "../test_helper"

class CreatePayloadTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end
  # if missing payload, return a 400
  # if we already received a request, return 403
  # if the application is not registered, return 403
  # if succes, return 200
  def test_it_does_not_create_a_payload_with_parameters_missing
    skip
    assert_equal 0, PayloadRequest.count

    post 'sources/JumpstartLabs/data', {"payload"=>
      "{\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "IDENTIFIER"=>"jumpstartlab"}

      assert_equal 0, PayloadRequest.count

      assert_equal 400, last_response.status
  end

  def test_it_creates_a_payload_with_valid_attributes
    skip
    assert_equal 0, PayloadRequest.count

    post 'sources/JumpstartLabs/data', {"payload"=>
  "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 "splat"=>[],
 "captures"=>["jumpstartlab"],
 "IDENTIFIER"=>"jumpstartlab"}

    assert_equal 1, PayloadRequest.count

    assert_equal 200, last_response.status
  end


  def test_it_does_not_create_an_already_received_payload
    #Digest::SHA1.hexdigest params['payload']
  end

end
#   def test_it_creates_a_client_with_valid_attributes
#     assert_equal 0, Client.count
#
#     post '/sources',  {identifier: "Turing", root_url: "https://www.turing.io/"}
#
#     assert_equal 1, Client.count
#     assert_equal 200, last_response.status
#     assert_equal "Turing:https://www.turing.io/", last_response.body
#   end
#
#   def test_it_does_not_create_a_client_with_parameters_missing
#     assert_equal 0, Client.count
#
#     post '/sources',  {identifier: "", root_url: ""}
#
#     assert_equal 0, Client.count
#     assert_equal 400, last_response.status
#     assert_equal "Identifier can't be blank, Root url can't be blank",
#     last_response.body
#
#     post '/sources',  {identifier: "Turing", root_url: nil}
#
#     assert_equal 0, Client.count
#     assert_equal 400, last_response.status
#     assert_equal "Root url can't be blank", last_response.body
#
#     post '/sources',  {identifier: nil, root_url: "https://www.turing.io/"}
#
#     assert_equal 0, Client.count
#     assert_equal 400, last_response.status
#     assert_equal "Identifier can't be blank", last_response.body
#   end
#
#   def test_it_does_not_create_a_client_without_a_unique_identifier
#     assert_equal 0, Client.count
#
#     post '/sources',  {identifier: "Turing", root_url: "https://www.turing.io/"}
#
#     assert_equal 1, Client.count
#
#     post '/sources',  {identifier: "Turing", root_url: "https://www.turing.io/"}
#
#     assert_equal 1, Client.count
#     assert_equal 403, last_response.status
#
#     assert_equal "Identifier has already been taken", last_response.body
#
#     post '/sources',  {identifier: "Lorax", root_url: "https://www.turing.io/"}
#
#     assert_equal 2, Client.count
#     assert_equal 200, last_response.status
#     assert_equal "Lorax:https://www.turing.io/", last_response.body
#   end
# end
