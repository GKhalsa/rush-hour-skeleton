require_relative '../test_helper'

class ReferrerTest < Minitest::Test
  include TestHelpers

  def test_it_knows_its_url
    referrer = Referrer.create({:url => "http://www.google.com"})

    assert_equal "http://www.google.com", referrer.url
  end

  def test_is_invalid_with_missing_url
    referrer = Referrer.create(url: "")

    refute referrer.valid?
  end

  def test_its_association_knows_the_three_most_popular_referrers
    skip
  end
end
