require_relative "../test_helper"

class UserCanRegisterTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_register_with_valid_inputs
    visit '/'

    fill_in "identifier[identifier]", with: "Google"
    fill_in "root_url[root_url]",   with: "/google.com"
    click_button "Submit"

    assert '/sources/Google', current_path
    assert page.has_content?("no payload data has been received for this source")

  end

  def test_user_can_not_register_without_filling_both_fields
    visit '/'

    fill_in "identifier[identifier]", with: "Google"
    click_button "Submit"

    assert '/errors', current_path

    assert page.has_content?("You must fill in both fields to register")

    click_button "try again"

    assert '/', current_page

    fill_in "root_url[root_url]",   with: "/google.com"
    click_button "Submit"

    assert '/errors', current_page

    assert page.has_content?("You must fill in both fields to register")
  end

  def test_user_can_not_register_if_identifier_already_exists
    visit '/'

    fill_in "identifier[identifier]", with: "Google"
    fill_in "root_url[root_url]",   with: "/google.com"
    click_button "Submit"

    assert '/sources/Google', current_path
    assert page.has_content?("no payload data has been received for this source")

    visit '/'

    fill_in "identifier[identifier]", with: "Google"
    fill_in "root_url[root_url]",   with: "/google2.com"
    click_button "Submit"

    assert '/errors', current_page

    assert page.has_content?("You must use a unique name to register")
  end

end
