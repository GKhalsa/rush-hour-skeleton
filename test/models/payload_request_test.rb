require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_it_assigns_attributes_properly
    create_payloads(1)
    id = PayloadRequest.all[-1].id
    payload = PayloadRequest.find(id)

    assert_equal "http://jumpstartlab1.com/blog", payload.url
    assert_equal  Time.parse("2013-02-16 21:38:28 -0700"), payload.requested_at
    assert_equal  37, payload.responded_in
    assert_equal  "http://jumpstartlab1.com", payload.referred_by
    assert_equal  "GET", payload.request_type
    assert_equal  "d1 ", payload.parameters
    assert_equal  "socialLogin1", payload.event_name
    assert_equal  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", payload.user_agent
    assert_equal  19201, payload.resolution_width
    assert_equal  12801, payload.resolution_height
    assert_equal  "63.29.38.211", payload.ip.to_s

    assert_equal 1, PayloadRequest.count
  end

  def test_it_validates
    create_payloads(1)

    assert_equal 1, PayloadRequest.count

    PayloadRequest.create({
      :url               => "http://jumpstartlab.com/blog",
      })
    assert_equal 1, PayloadRequest.count

  end

end
