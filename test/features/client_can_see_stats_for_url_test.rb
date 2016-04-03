require_relative "../test_helper"

class ClientCanSeeStatsTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  # def setup
  #   binding.pry
  #   Url.create(address: "http://jumpstartlab.com/blog")
  #   create_payload_for_url(3)
  #   super
  # end

  def test_client_can_see_stats_for_url

    Url.create(address: "http://jumpstartlab.com/blog")
    create_payload_for_urls(3)

    visit '/sources/JumpstartLab/urls/blog'
    assert '/sources/JumpstartLab/urls/blog', current_path

    # save_and_open_page
    within ('#max_response_time') do
      assert page.has_content?("39")
    end

    within ('#min_response_time') do
      assert page.has_content?("37")
    end

    within ('#ordered_response_times') do
      assert page.has_content?("[39, 38, 37]")
    end

    within ('#average_response_time') do
      assert page.has_content?("38.0")
    end

    within ('#verbs') do
      assert page.has_content?('["GET"]')
    end

    within ('#best_referrers') do
      assert page.has_content?('["http://jumpstartlab.com"]')
    end

    within ('#best_user_agents') do
      assert page.has_content?('	[["Mozilla/5.0", "Macintosh"]]')
    end
  end

  def create_payload_for_urls(num)
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
        :client         => Client.find_or_create_by(identifier: "JumpstartLab", rootUrl: "http://jumpstartlab.com"),
        :sha            => "#{i}"
        })
    end
  end
end
