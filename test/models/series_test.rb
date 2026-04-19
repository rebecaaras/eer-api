require "test_helper"

class SeriesTest < ActiveSupport::TestCase
  test "should add one series" do
    assert_difference("Series.count", 1) do
      Series.create(
        {
          country_code: "CA",
          country_name: "Canada",
          frequency: "Monthly",
          series_type: "Real",
          basket: "Broad"
        })
    end
  end

  test "should not save series without data" do
    no_code = Series.new(
      country_name: "Brazil",
      frequency: "Monthly",
      series_type: "Nominal",
      basket: "Narrow"
    )
    assert_not no_code.save, "Saved series without country_code"

    no_country_name = Series.new(
      country_code: "BR",
      frequency: "Monthly",
      series_type: "Nominal",
      basket: "Narrow"
    )
    assert_not no_country_name.save, "Saved series without country_name"

    no_frequency = Series.new(
      country_name: "Brazil",
      country_code: "BR",
      series_type: "Nominal",
      basket: "Narrow"
    )
    assert_not no_frequency.save, "Saved series without frequency"

    no_series_type = Series.new(
      country_name: "Brazil",
      country_code: "BR",
      frequency: "Monthly",
      basket: "Narrow"
    )
    assert_not no_series_type.save, "Saved series without series_type"

    no_basket = Series.new(
      country_name: "Brazil",
      country_code: "BR",
      frequency: "Monthly",
      series_type: "Nominal",
    )
    assert_not no_basket.save, "Saved series without basket"
  end
end
