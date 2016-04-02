require_relative "../test_helper"

class UserCanRegisterTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_register_with_valid_inputs
    visit '/'

    fill_in "identifier", with: "Google"
    fill_in "root_url",   with: "/google.com"
    click_button "Submit"

    assert '/sources/Google', current_path

    assert page.has_content?("no payload data has been received for this source")

  end

  def test_user_can_not_register_without_filling_both_fields
    visit '/'

    fill_in "identifier", with: "Google"
    click_button "Submit"

    assert '/errors', current_path

    assert page.has_content?("You have an error")

    click_link "Try Again"

    assert '/', current_path

    fill_in "root_url",   with: "/google.com"
    click_button "Submit"

    assert '/errors', current_path

    assert page.has_content?("You have an error")
  end

  def test_user_can_not_register_if_identifier_already_exists
    visit '/'

    fill_in "identifier", with: "Google"
    fill_in "root_url",   with: "/google.com"
    click_button "Submit"

    assert '/sources/Google', current_path
    assert page.has_content?("no payload data has been received for this source")

    visit '/'

    fill_in "identifier", with: "Google"
    fill_in "root_url",   with: "/google2.com"
    click_button "Submit"

    assert '/error', current_path

    assert page.has_content?("You have an error")
  end

end
