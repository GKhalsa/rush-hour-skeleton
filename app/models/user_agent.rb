class UserAgent < ActiveRecord::Base
  validates :browser, presence: true
  validates :os,      presence: true
  has_many :payload_request

  def self.browser_breakdown
    group(:browser).count
  end

  def self.os_breakdown
    group(:os).count
  end
end
