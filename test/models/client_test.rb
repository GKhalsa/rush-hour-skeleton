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
end
