class Url < ActiveRecord::Base
  validates :address, presence: true
  has_many :payload_request

  def self.ranked
    uniq.group('urls.id').order(:address).pluck(:address)
  end
end
