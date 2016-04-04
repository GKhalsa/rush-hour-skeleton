require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers


  def create_payload_for_url(num)
    num.times do |i|
      PayloadRequest.create({
        :url            => Url.find_or_create_by(address: "http://jumpstartlab.com/blog"),
        :requested_at   => "2013-02-16 21:38:2#{i} -0700",
        :responded_in   => (37 + i),
        :referrer       => Referrer.create(address: "http://jumpstartlab.com"),
        :request_type   => RequestType.find_or_create_by(name: "GET"),
        :parameters     => "d#{i + 1} ",
        :event_type     => EventType.create(name: "socialLogin#{i + 1}"),
        :user_agent     => UserAgent.create(browser: "Mozilla/5.0", os: "Macintosh"),
        :resolution     => Resolution.create(width: "1920#{i + 1}", height: "1280#{i + 1}"),
        :ip             => "63.29.38.211",
        :sha            => "#{i}"
        })
    end
  end

  def test_it_knows_its_url
    url = Url.create({:address => "http://www.google.com"})

    assert_equal "http://www.google.com", url.address
  end

  def test_is_invalid_with_missing_url
    url = Url.create(address: "")

    refute url.valid?
  end

  def test_maximum_response_time_for_url
    create_payload_for_url(3)

    url = PayloadRequest.first.url

    assert_equal 39,url.max_response_time
  end

  def test_minimum_response_time_for_url
    create_payload_for_url(3)

    url = PayloadRequest.first.url

    assert_equal 37,url.min_response_time
  end

  def test_it_returns_all_response_times_in_order
    create_payload_for_url(3)
    url = PayloadRequest.first.url

    assert_equal "39, 38, 37", url.ordered_response_times
  end

  def test_average_response_time_for_speficif_Url
    create_payload_for_url(3)
    url = PayloadRequest.first.url

    assert_equal 38, url.average_response_time

  end

  def test_list_of_http_verbs
    create_payload_for_url(2)

    PayloadRequest.create({
      :url            => Url.find_or_create_by(address: "http://jumpstartlab.com/blog"),
      :requested_at   => "2013-02-16 21:38:28 -0700",
      :responded_in   => 37,
      :referrer       => Referrer.create(address: "http://jumpstartlab.com"),
      :request_type   => RequestType.find_or_create_by(name: "POST"),
      :parameters     => "d ",
      :event_type     => EventType.create(name: "socialLogin"),
      :user_agent     => UserAgent.create(browser: "Mozilla/5.0", os: "Macintosh"),
      :resolution     => Resolution.create(width: "1920", height: "1280"),
      :ip             => "63.29.38.211",
      :sha            => 3
      })

      url = PayloadRequest.first.url

      assert_equal "GET, POST", url.verbs
  end

  def test_returns_3_best_referrers
    create_payload_for_url(10)
    url = PayloadRequest.first.url
    PayloadRequest.all[1].referrer.update(address: "http://jumpstartlab1.com")
    PayloadRequest.all[2].referrer.update(address: "http://jumpstartlab1.com")
    PayloadRequest.all[3].referrer.update(address: "http://jumpstartlab2.com")
    PayloadRequest.all[4].referrer.update(address: "http://jumpstartlab2.com")
    PayloadRequest.all[5].referrer.update(address: "http://jumpstartlab2.com")
    PayloadRequest.all[6].referrer.update(address: "http://jumpstartlab3.com")
    PayloadRequest.all[7].referrer.update(address: "http://jumpstartlab3.com")
    PayloadRequest.all[8].referrer.update(address: "http://jumpstartlab3.com")
    PayloadRequest.all[9].referrer.update(address: "http://jumpstartlab3.com")

    best = "http://jumpstartlab3.com, http://jumpstartlab2.com, http://jumpstartlab1.com"

    assert_equal best, url.best_referrers
  end

  def test_returns_3_most_popular_user_agents
    create_payload_for_url(10)
    url = PayloadRequest.first.url
    PayloadRequest.all[1].user_agent.update(browser: "Mozilla/2.0", os: "Macintosh")
    PayloadRequest.all[2].user_agent.update(browser: "Mozilla/5.0", os: "Macintosh")
    PayloadRequest.all[3].user_agent.update(browser: "Mozilla/6.0", os: "Macintosh")
    PayloadRequest.all[4].user_agent.update(browser: "Mozilla/6.0", os: "Macintosh")
    PayloadRequest.all[5].user_agent.update(browser: "Mozilla/6.0", os: "Macintosh")
    PayloadRequest.all[6].user_agent.update(browser: "Mozilla/7.0", os: "MicroSoft")
    PayloadRequest.all[7].user_agent.update(browser: "Mozilla/7.0", os: "MicroSoft")
    PayloadRequest.all[8].user_agent.update(browser: "Mozilla/7.0", os: "MicroSoft")
    PayloadRequest.all[9].user_agent.update(browser: "Mozilla/7.0", os: "MicroSoft")

    top_three_best_agents = "Mozilla/7.0, MicroSoft, Mozilla/6.0, Macintosh, Mozilla/5.0, Macintosh"
    
    assert_equal top_three_best_agents, url.best_user_agents
  end

  def test_it_can_rank_urls
    create_payloads(3)
    PayloadRequest.last.url.update(address: "http://jumpstartlab.com/blog1")

    assert_equal ["http://jumpstartlab.com/blog1", "http://jumpstartlab.com/blog2"], Url.ranked
  end
end
