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
              :url               => "http://jumpstartlab#{i + 1}.com/blog",
              :requested_at      => "2013-02-16 21:38:28 -0700",
              :responded_in      => 37,
              :referred_by       => "http://jumpstartlab#{i + 1}.com",
              :request_type      => "GET",
              :parameters        => "d#{i + 1} ",
              :event_name        => "socialLogin#{i + 1}",
              :user_agent        => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              :resolution_width  => "1920#{i + 1}",
              :resolution_height => "1280#{i + 1}",
              :ip                => "63.29.38.211"
                               })
    end
  end

  def create_referrers(num, address)
    num.times do
      Referrer.create({:url => "#{address}"})
    end
  end
end
