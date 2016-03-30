require 'pry'
class Resolution < ActiveRecord::Base
  validates :width,   presence: true
  validates :height,  presence: true
  has_many :payload_requests

  def self.breakdown
    group(:width, :height).count
  end

end
