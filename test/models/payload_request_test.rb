require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_it_assigns_attributes_properly
    create_payloads(1)
    payload = PayloadRequest.last

    assert_equal "http://jumpstartlab1.com/blog", payload.url.address
    assert_equal  Time.parse("2013-02-17 04:38:28 UTC"), payload.requested_at
    assert_equal  37, payload.responded_in
    assert_equal  "http://jumpstartlab1.com", payload.referrer.address
    assert_equal  "GET", payload.request_type.name
    assert_equal  "d1 ", payload.parameters
    assert_equal  "socialLogin1", payload.event_type.name
    assert_equal  "Macintosh", payload.user_agent.os
    assert_equal  "Mozilla", payload.user_agent.browser
    assert_equal  1921, payload.resolution.width
    assert_equal  1281, payload.resolution.height
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

    PayloadRequest.create({
      :url            => Url.find_or_create_by(address: "http://jumpstartlab1.com/blog"),
      :requested_at   => "2013-02-16 21:38:28 -0700",
      :responded_in   => 37,
      :referrer       => Referrer.find_or_create_by(address: "http://jumpstartlab1.com"),
      :request_type   => RequestType.find_or_create_by(name: "GET"),
      :parameters     => "d1",
      :event_type     => EventType.find_or_create_by(name: "socialLogin1"),
      :user_agent     => UserAgent.find_or_create_by(browser: "Mozilla", os: "Macintosh"),
      :resolution     => Resolution.find_or_create_by(width: "1921", height: "1281"),
      :ip             => "63.29.38.211",
      :client         => Client.find_or_create_by(identifier: "JumpstartLab", root_url: "www.jumpstartlab com"),
      :sha            => "0"
      })

  end

  def test_can_gather_average_response_times_across_requests
    create_payloads(3)
    assert_equal 38, PayloadRequest.average_response_time
  end

  def test_it_returns_max_response_time_across_all_requests
    create_payloads(3)
    assert_equal 39, PayloadRequest.max_response_time
  end

  def test_it_returns_min_response_time_across_all_requests
    create_payloads(3)
    assert_equal 37, PayloadRequest.min_response_time
  end

end
