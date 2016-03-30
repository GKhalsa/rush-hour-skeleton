require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_it_knows_its_user_browser_and_os
    user_agent = UserAgent.create({:browser => "Mozilla/5.0",
                                   :os => "Macintosh"})
    assert_equal "Mozilla/5.0", user_agent.browser
    assert_equal "Macintosh", user_agent.os
  end

  def test_is_invalid_with_missing_user_agent
    user_agent = UserAgent.create(browser: "")
    refute user_agent.valid?
  end

  def test_it_can_provide_browser_breakdown
    create_payloads(3)
    PayloadRequest.last.user_agent.update(browser: "Chrome")

    assert_equal({"Mozilla/5.0"=>2, "Chrome"=>1}, UserAgent.browser_breakdown)
  end

  def test_it_can_provide_an_os_breakdown
    create_payloads(3)
    PayloadRequest.last.user_agent.update(os: "Windows")

    assert_equal({"Macintosh"=>2, "Windows"=>1},UserAgent.os_breakdown)
  end
end
