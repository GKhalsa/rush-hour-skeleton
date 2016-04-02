require_relative "../test_helper"

class ClientTest < Minitest::Test
  include TestHelpers

  def test_it_knows_its_root_url
    client = Client.create({root_url:"www.turing.io"})

    assert_equal "www.turing.io", client.root_url
  end

  def test_is_invalid_with_missing_address
    client = Client.create(root_url: "")

    refute client.valid?
  end

  def test_client_knows_its_most_frequent_verbs
    create_payloads(3)
    request_type = RequestType.create(name: "PUT")
    PayloadRequest.first.update(request_type_id: request_type.id)

    expected = { "GET" => 2, "PUT" => 1 }

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
    url = Url.create(address: "http://jumpstartlab2.com/blog")
    PayloadRequest.first.update(url_id: url.id)

  assert_equal [["http://jumpstartlab2.com/blog", 2], ["http://jumpstartlab3.com/blog", 1]], Client.first.url_breakdown
  end

  def test_browser_breakdown
    create_payloads(3)

    assert_equal({"Mozilla"=>3}, Client.first.browser_breakdown)
  end

  def test_screen_resolution_breakdown
    create_payloads(3)

    assert_equal({[1921, 1281]=>1, [1922, 1282]=>1, [1923, 1283]=>1}, Client.first.screen_resolution_breakdown)
  end

end
