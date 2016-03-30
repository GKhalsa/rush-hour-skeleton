require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_it_knows_its_resolution_width_and_height
    resolution = Resolution.create({:width => 1920,
                                    :height => 1280})

    assert_equal 1920, resolution.width
    assert_equal 1280, resolution.height
  end

  def test_is_invalid_with_missing_resolution_width_and_height
    resolution = Resolution.create(width: "")

    refute resolution.valid?
  end

  def test_breakdown_of_screen_resolutions
    create_payloads(3)

    assert_equal "", Resolution.resolution_breakdown
  end
end
