require "test_helper"

class SeriesTest < ActiveSupport::TestCase
  test "should add one series" do
    assert_difference("Series.count", 1) do
      Series.create(
        country_code: "BR",
        country_name: "Brazil",
        frequency: "Monthly",
        series_type: "Nominal",
        basket: "Broad"
      )
    end
  end
end
