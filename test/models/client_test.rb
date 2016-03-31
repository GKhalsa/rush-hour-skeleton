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
end
