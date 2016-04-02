require_relative "../test_helper"

class UserSeeWelcomePageTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_sees_welcome
    visit '/'
    within('#header_id') do
      assert page.has_content?("Welcome!")
    end

    within('#registration_form') do
      assert page.has_content?("register your site here")
    end
  end

end
