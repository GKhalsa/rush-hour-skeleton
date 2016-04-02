require_relative "../test_helper"

class CreatePayloadTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_it_does_not_create_a_payload_with_parameters_missing
    assert_equal 0, PayloadRequest.count

    Client.create(identifier: "JumpstartLabs", rootUrl: "JumpstartLabs")
    post 'sources/JumpstartLabs/data', {"payload"=>
      "{\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "IDENTIFIER"=>"jumpstartlab"}

    assert_equal 0, PayloadRequest.count

    assert_equal 400, last_response.status
    assert_equal "Url can't be blank: Missing Payload", last_response.body
  end

  def test_it_does_not_create_an_already_received_payload
    assert_equal 0, PayloadRequest.count

    Client.create(identifier: "JumpstartLabs", rootUrl: "JumpstartLabs")
    post 'sources/JumpstartLabs/data', {"payload"=>
  "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 "splat"=>[],
 "captures"=>["jumpstartlab"],
 "IDENTIFIER"=>"jumpstartlab"}

    assert_equal 1, PayloadRequest.count

    post 'sources/JumpstartLabs/data', {"payload"=>
  "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 "splat"=>[],
 "captures"=>["jumpstartlab"],
 "IDENTIFIER"=>"jumpstartlab"}


    assert_equal 1, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Sha has already been taken: Already Received Payload Request", last_response.body
  end

  def test_it_does_not_create_a_payload_without_a_client
    assert_equal 0, PayloadRequest.count

    Client.create(identifier: "JumpstartLabs", rootUrl: "JumpstartLabs")
    post 'sources/JumpstartLabs/data', {"payload"=>
  "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 "splat"=>[],
 "captures"=>["jumpstartlab"],
 "IDENTIFIER"=>"jumpstartlab"}

    assert_equal 1, PayloadRequest.count

    post 'sources/JumpstartLabs/data', {"payload"=>
  "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 "splat"=>[],
 "captures"=>["jumpstartlab"],
 "IDENTIFIER"=>"jumpstartlab"}

    assert_equal 1, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Sha has already been taken: Already Received Payload Request", last_response.body
  end

  def test_it_creates_a_payload_with_valid_attributes
    assert_equal 0, PayloadRequest.count

    Client.create(identifier: "JumpstartLabs", rootUrl: "JumpstartLabs")
    post 'sources/JumpstartLabs/data', {"payload"=>
  "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 "splat"=>[],
 "captures"=>["jumpstartlab"],
 "IDENTIFIER"=>"jumpstartlab"}

    assert_equal 1, PayloadRequest.count

    assert_equal 200, last_response.status
  end
end
