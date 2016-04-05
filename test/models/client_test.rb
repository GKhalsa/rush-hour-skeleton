require_relative "../test_helper"

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_knows_its_root_url
    client = Client.create({rootUrl:"www.turing.io"})

    assert_equal "www.turing.io", client.rootUrl
  end

  def test_is_invalid_with_missing_address
    client = Client.create(rootUrl: "")

    refute client.valid?
  end

  def test_client_knows_its_most_frequent_verbs
    create_payloads(3)
    request_type = RequestType.create(name: "PUT")
    PayloadRequest.first.update(request_type_id: request_type.id)

    expected = "GET => 2, PUT => 1"

    assert_equal expected, Client.first.most_frequent_verbs
  end

  def test_client_knows_its_average_response_time
    create_payloads(3)

    assert_equal 38, Client.first.average_response_time
  end

  def test_client_knows_its_max_response_time
    create_payloads(3)

    assert_equal 39, Client.first.max_response_time
  end

  def test_client_knows_its_min_response_time
    create_payloads(3)

    assert_equal 37, Client.first.min_response_time
  end

  def test_all_verbs_used_on_client
    create_payloads(3)
    request_type = RequestType.create(name: "PUT")
    PayloadRequest.first.update(request_type_id: request_type.id)

    assert_equal ['GET', 'PUT'], Client.first.all_verbs
  end

  def test_url_breakdown
    create_payloads(3)
    url = Url.create(address: "http://jumpstartlab.com/blog2")
    PayloadRequest.first.update(url_id: url.id)

    assert_equal [["http://jumpstartlab.com/blog2", 2], ["http://jumpstartlab.com/blog3", 1]], Client.first.url_breakdown
  end

  def test_browser_breakdown
    create_payloads(3)

    assert_equal 'Mozilla => 3', Client.first.browser_breakdown
  end

  def test_screen_resolution_breakdown
    create_payloads(3)

    assert Client.first.screen_resolution_breakdown.include?("1923 X 1283 => 1")
  end

  def test_it_can_find_total_events
    create_payloads(3)

    assert_equal 1, Client.first.total_event("socialLogin1")
    assert_equal 1, Client.first.total_event("socialLogin2")
  end

  def test_it_can_find_events_by_hour
    create_payloads(3)
    expected = {4.0 => 1}

    assert_equal expected, Client.first.total_event_by_hours("socialLogin1")
  end
end
