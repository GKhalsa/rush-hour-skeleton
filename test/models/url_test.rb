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

  def test_it_can_rank_urls
    create_payloads(3)
    PayloadRequest.last.url.update(address: "http://jumpstartlab1.com/blog")

    assert_equal ["http://jumpstartlab1.com/blog", "http://jumpstartlab2.com/blog"], Url.ranked
  end
end
