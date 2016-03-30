class UserAgent < ActiveRecord::Base
  validates :browser, presence: true
  validates :os,      presence: true
  has_many :payload_requests

  def self.browser_breakdown
    PayloadRequest.group(:user_agent_id).count
  end

  def self.os_breakdown
    PayloadRequest.group(:user_agent).pluck(:os).count
    # payload_requests.group(ids).order(:os)
  end
end
