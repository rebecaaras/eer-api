require "test_helper"

class ObservationTest < ActiveSupport::TestCase
  test "should add one observation" do
    assert_difference("Observation.count", 1) do
      obs = Observation.new(
        {
          series_id: Series.find_by(country_code: "BE").id,
          observed_on: "2025-05-01",
          value: 152.56
        }
      )

      obs.save!
    end
  end
end
