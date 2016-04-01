require 'user_agent_parser'

class PayloadBuilder
  attr_reader :params

  def initialize(params)
    parsed            = parse_params(params)
    @url              = parsed['url']
    @requested_at     = parsed['requestedAt']
    @responded_in     = parsed['respondedIn']
    @referred_by      = parsed['referredBy']
    @request_type     = parsed['requestType']
    @event_name       = parsed['eventName']
    @user_agent       = parsed['userAgent']
    @resolutionwidth  = parsed['resolutionWidth']
    @resolutionheight = parsed['resolutionHeight']
    @ip               = parsed['ip']
    create_payload
  end

  def create_payload
    payload_request = PayloadRequest.new({
      :url            => Url.find_or_create_by(address: @url),
      :requested_at   => @requested_at,
      :responded_in   => @responded_in,
      :referrer       => Referrer.find_or_create_by(address: @referred_by),
      :request_type   => RequestType.find_or_create_by(name: @request_type),
      :parameters     => [],
      :event_type     => EventType.find_or_create_by(name: @event_name),
      :user_agent     => UserAgent.find_or_create_by(browser: parse_user_agent_browser, os: parse_user_agent_os),
      :resolution     => Resolution.find_or_create_by(width: @resolutionwidth, height: @resolutionheight),
      :ip             => @ip,
      :client         => Client.find_or_create_by(identifier: "JumpstartLab", root_url: "www.jumpstartlab com")
      })
    if payload_request.save
      [200, "Success!"]
    else
      binding.pry
      [400, "No args"]
    end
  end

  def parse_user_agent_browser
    UserAgentParser.parse(@user_agent).to_s
  end

  def parse_user_agent_os
    UserAgentParser.parse(@user_agent).os.to_s
  end

  def parse_params(params)
    JSON.parse(params['payload'])
  end
end

# {"payload"=>"{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
#  "splat"=>[],"captures"=>["jumpstartlab"],
#  "IDENTIFIER"=>"jumpstartlab"}
