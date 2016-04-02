require_relative "../test_helper"

class PayloadBuilderTest < Minitest::Test
  include TestHelpers

  def test_it_can_create_a_payload_from_client_data
    assert_equal 0, PayloadRequest.all.count

    Client.create(identifier: "JumpstartLabs", root_url: "JumpstartLabs")
    params = {"payload"=>
  "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
 "splat"=>[],
 "captures"=>["JumpstartLabs"],
 "IDENTIFIER"=>"JumpstartLabs"}
    PayloadBuilder.new(params)

    assert_equal 1, PayloadRequest.count
  end
end
