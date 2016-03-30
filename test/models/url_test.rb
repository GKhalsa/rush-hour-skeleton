require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_it_knows_its_url
    url = Url.create({:address => "http://www.google.com"})
    assert_equal "http://www.google.com", url.address
  end

  def test_is_invalid_with_missing_url
    url = Url.create(address: "")
    refute url.valid?
  end
end
