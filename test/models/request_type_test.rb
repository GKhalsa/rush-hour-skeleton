require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_it_knows_its_name
    request_type = RequestType.create({:name => "GET"})
    assert_equal "GET", request_type.name
  end

  def test_is_invalid_with_missing_name
    request_type = RequestType.create(name: "")
    refute request_type.valid?
  end
end
