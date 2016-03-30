require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_it_assigns_attributes_properly
    create_payloads(1)
    payload = PayloadRequest.last

    assert_equal "http://jumpstartlab1.com/blog", payload.url.address
    assert_equal  Time.parse("2013-02-16 21:38:28 -0700"), payload.requested_at
    assert_equal  37, payload.responded_in
    assert_equal  "http://jumpstartlab1.com", payload.referrer.address
    assert_equal  "GET", payload.request_type.name
    assert_equal  "d1 ", payload.parameters
    assert_equal  "socialLogin1", payload.event_type.name
    assert_equal  "Macintosh", payload.user_agent.os
    assert_equal  "Mozilla/5.0", payload.user_agent.browser
    assert_equal  19201, payload.resolution.width
    assert_equal  12801, payload.resolution.height
    assert_equal  "63.29.38.211", payload.ip.to_s

    assert_equal 1, PayloadRequest.count
  end

  def test_it_validates
    create_payloads(1)

    assert_equal 1, PayloadRequest.count

    PayloadRequest.create({
      :url_id => "http://jumpstartlab.com/blog",
      })
    assert_equal 1, PayloadRequest.count

  end

end
