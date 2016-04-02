require 'user_agent_parser'

class PayloadBuilder
  attr_reader :status_id, :body

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
    @identifier       = params['IDENTIFIER']
    @root_url         = params['captures']
    @sha              = Digest::SHA1.hexdigest(params['payload'])
    @status_id        = nil
    @body             = nil
    evaluate_payload
  end

  def evaluate_payload
    payload_request = create_payload
    if Client.where(identifier: @identifier).empty?
      @status_id = 403
      @body      = "Application not registered. Please contact us to obtain service."
    else
      if payload_request.save
        @status_id = 200
        @body      = "Success!"
      elsif payload_request.errors.full_messages.join(", ") == "Sha has already been taken"
        @status_id = 403
        @body      = payload_request.errors.full_messages.join(', ') + ": Already Received Payload Request"
      else
        @status_id = 400
        @body      = payload_request.errors.full_messages.join(', ') + ": Missing Payload"
      end
    end
  end

  def create_payload
    PayloadRequest.new({
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
      :client         => Client.where(identifier: @identifier, rootUrl: @root_url).first,
      :sha            => @sha
      })
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
