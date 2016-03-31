class RequestType < ActiveRecord::Base
  validates :name, presence: true
  has_many :payload_requests

  has_many :clients, through: :payload_requests

  def self.all_verbs
    uniq.pluck(:name)
  end
end
