class Client < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true
  has_many :payload_requests

  has_many :request_types, through: :payload_requests

  def most_frequent_verbs
    request_types.group(:name).count
  end
end
