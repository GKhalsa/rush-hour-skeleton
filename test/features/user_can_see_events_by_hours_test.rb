require_relative "../test_helper"

class UserCanSeeEventsByHours < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def setup
    create_payloads(3)
  end

  def test_client_can_see_stats
    visit '/sources/JumpstartLab/events/socialLogin1'
    assert '/sources/JumpstartLab/events/socialLogin1', current_path

    within('#by_hours') do
      assert page.has_content?("4:00")
    end
  end

  def test_client_will_see_no_data_message_if_the_event_type_hasnt_been_requested
    visit '/sources/JumpstartLab/events/bettercallsal'

    assert '/sources/JumpstartLab/events/bettercallsal', current_path

    within ('#message') do
      assert page.has_content?("This event hasn't been requested")
    end
  end
end
