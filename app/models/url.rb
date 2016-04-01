require 'pry'
class Url < ActiveRecord::Base
  validates :address, presence: true
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :uagents, through: :payload_requests

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def ordered_response_times
    payload_requests.order(responded_in: :desc).pluck(:responded_in)
  end

  def average_response_time
    payload_requests.average(:responded_in)
  end

  def verbs
    request_types.pluck(:name).uniq
  end

  def best_referrers
    referrers.order(address: :desc).pluck(:address).uniq.take(3)
  end

  def best_uagents
    uagents.order(browser: :desc, os: :desc).pluck(:browser, :os).uniq.take(3)
  end

  def self.ranked
    uniq.group('urls.id').order(:address).pluck(:address)
  end
end
