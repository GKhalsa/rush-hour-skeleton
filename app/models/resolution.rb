require 'pry'
class Resolution < ActiveRecord::Base
  validates :width,   presence: true
  validates :height,  presence: true
  has_many :payload_request

  def self.resolution_breakdown
    group(:width, :height).count
  end

end
