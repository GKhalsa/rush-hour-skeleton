require_relative "../test_helper"

class ClientCanSeeStatsTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def setup
    create_payloads(3)
  end

  def test_client_can_see_stats
    visit '/sources/JumpstartLab'
    assert '/sources/JumpstartLab', current_path

    within('#average_response_time') do
      assert page.has_content?("38.0")
    end

    within ('#max_response_time') do
      assert page.has_content?("39.0")
    end

    within ('#min_response_time') do
      assert page.has_content?("37.0")
    end

    within ('#most_frequent_request_type') do
      assert page.has_content?('{"GET"=>3}')
    end

    within ('#all_http_verbs') do
      assert page.has_content?('["GET"]')
    end

    within ('#urls_most_to_least_requested') do
      assert page.has_content?('[["http://jumpstartlab1.com/blog", 1], ["http://jumpstartlab2.com/blog", 1], ["http://jumpstartlab3.com/blog", 1]]')
    end

    within ('#browser_breakdown') do
      assert page.has_content?('{"Mozilla"=>3}')
    end

    within ('#os_breakdown') do
      assert page.has_content?('{"Macintosh"=>3}')
    end

    within ('#screen_resolutions_breakdown') do
      save_and_open_page
      assert page.has_content?('{[1921, 1281]=>1, [1922, 1282]=>1, [1923, 1283]=>1}')
    end
  end
end
