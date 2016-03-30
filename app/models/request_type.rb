class RequestType < ActiveRecord::Base
  validates :name, presence: true
  has_many :payload_requests

  def self.most_frequent
    group('request_types.id').order(:name).limit(1).pluck(:name).first
  end

  def self.all_verbs
    uniq.pluck(:name)
  end
end
