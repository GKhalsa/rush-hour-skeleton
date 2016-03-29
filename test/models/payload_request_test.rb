require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test

  def test_it_assigns_attributes_properly
    payload = PayloadRequest.new({
            :url               => "http://jumpstartlab.com/blog",
            :requested_at      => "2013-02-16 21:38:28 -0700",
            :responded_in      => 37,
            :referred_by       => "http://jumpstartlab.com",
            :request_type      => "GET",
            :parameters        => "",
            :event_name        => "socialLogin",
            :user_agent        => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
            :resolution_width  => "1920",
            :resolution_height => "1280",
            :ip                =>   "63.29.38.211"
                             })

    assert_equal "Robo", payload.url
    # assert_equal "Denver", robo.city
    # assert_equal "CO", robo.state
    # assert_equal "06/03/1746", robo.birthdate
    # assert_equal "3000", robo.date_hired
    # assert_equal "magic", robo.department
  end

end
