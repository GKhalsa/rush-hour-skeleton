require_relative '../test_helper'
require 'pry'
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
    user_agent1 = UserAgent.create(browser: "Chrome", os: "Macintosh")
    user_agent2 = UserAgent.create(browser: "Mozilla", os: "Windows")
    PayloadRequest.all[0].update(user_agent_id: user_agent1.id)
    PayloadRequest.all[1].update(user_agent_id: user_agent2.id)

    expected = {"Mozilla"=>2, "Chrome"=>1}

    assert_equal expected, UserAgent.browser_breakdown
  end

  def test_it_can_provide_an_os_breakdown
    create_payloads(3)
    user_agent1 = UserAgent.create(browser: "Chrome", os: "Windows")
    user_agent2 = UserAgent.create(browser: "Mozilla", os: "Macintosh")
    PayloadRequest.all[0].update(user_agent_id: user_agent1.id)
    PayloadRequest.all[1].update(user_agent_id: user_agent2.id)

    expected = {"Macintosh"=>2, "Windows"=>1}

    assert_equal expected, UserAgent.os_breakdown
  end
end
