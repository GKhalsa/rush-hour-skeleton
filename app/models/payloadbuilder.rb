require File.expand_path("../../config/environment", __FILE__)

class PayloadBuilder
  attr_reader :params

  def initialize(params)
    @url = params[:url]
    @requested_at = params[:requested_at]
    @responded_in = params[:responed_in]
    @referred_by = params[:referred_by]
    @request_type = params[:requested_type]
    @event_name = params[:event_name]
    @user_agent = params[:user_agent]
    @resolutionwidth = params[:resolutionwidth]
    @resolutionheight = params[:resolutionheight]
    @ip = params[:ip]
    create_payload
  end

  def create_payload
    PayloadRequest.create({
      :url            => Url.find_or_create_by(address: "http://jumpstartlab#{i + 1}.com/blog"),
      :requested_at   => "2013-02-16 21:38:28 -0700",
      :responded_in   => (37 + i),
      :referrer       => Referrer.find_or_create_by(address: "http://jumpstartlab#{i + 1}.com"),
      :request_type   => RequestType.find_or_create_by(name: "GET"),
      :parameters     => "d#{i + 1} ",
      :event_type     => EventType.find_or_create_by(name: "socialLogin#{i + 1}"),
      :user_agent     => UserAgent.find_or_create_by(browser: "Mozilla", os: "Macintosh"),
      :resolution     => Resolution.find_or_create_by(width: "#{i + 1 + 1920}", height: "#{i + 1 + 1280}"),
      :ip             => "63.29.38.211",
      :client         => Client.find_or_create_by(identifier: "JumpstartLab", root_url: "www.jumpstartlab com")
      })
  end

end
