require '../test_helper'
class PayloadRequestTest < Minitest::Test

  def test_payload_request_is_associated_with_related_objects
    pr = PayloadRequest.create(
      requested_at: "dklshg",
      responded_in: 10,
      referrer_id: Referrer.create(name: "http://google.com").id
      url_id: Url.create(name: "http://google.com").id
    )

  # pr.referrer #=> returns a Referrer object
    assert_equal "http://google.com", pr.referrer.name
  end
end


class CreateReferrers < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.text :name
    end
    remove_column :payload_requests, :referred_by
    add_column :payload_requests, :referrer_id, :integer
  end
end
