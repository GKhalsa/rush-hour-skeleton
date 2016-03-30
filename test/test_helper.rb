ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require



require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'rack/test'
require 'database_cleaner'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelpers

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_payloads(num)
    num.times do |i|
      PayloadRequest.create({
        :url            => Url.create(address: "http://jumpstartlab#{i + 1}.com/blog"),
        :requested_at   => "2013-02-16 21:38:28 -0700",
        :responded_in   => (37 + i),
        :referrer       => Referrer.create(address: "http://jumpstartlab#{i + 1}.com"),
        :request_type   => RequestType.create(name: "GET"),
        :parameters     => "d#{i + 1} ",
        :event_type     => EventType.create(name: "socialLogin#{i + 1}"),
        :user_agent     => UserAgent.create(browser: "Mozilla/5.0", os: "Macintosh"),
        :resolution     => Resolution.create(width: "#{i + 1 + 1920}", height: "#{i + 1 + 1280}"),
        :ip             => "63.29.38.211"
        })
    end
  end

  # def create_referrers(num, address)
  #   num.times do
  #     Referrer.create({:url => "#{address}"})
  #   end
  # end
end
