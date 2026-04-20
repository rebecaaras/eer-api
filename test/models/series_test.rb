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

  test "should not save series without country_code" do
    assert_raises(ActiveRecord::RecordInvalid) do
      Series.new(
        # country_code: "BR",
        country_name: "Brazil",
        frequency: "Monthly",
        series_type: "Nominal",
        basket: "Narrow"
      ).save!
    end
  end

  test "should not save series without frequency" do
    assert_raises(ActiveRecord::RecordInvalid) do
      Series.new(
        country_code: "BR",
        country_name: "Brazil",
        # frequency: "Monthly",
        series_type: "Nominal",
        basket: "Narrow"
      ).save!
    end
  end
  test "should not save series without series_type" do
    assert_raises(ActiveRecord::RecordInvalid) do
      Series.new(
        country_code: "BR",
        country_name: "Brazil",
        frequency: "Monthly",
        # series_type: "Nominal",
        basket: "Narrow"
      ).save!
    end
  end

  test "should not save series without basket" do
      assert_raises(ActiveRecord::RecordInvalid) do
        Series.new(
        country_code: "BR",
        country_name: "Brazil",
        frequency: "Monthly",
        series_type: "Nominal",
        # basket: "Narrow"
      ).save!
    end
  end

  test "should raise ActiveRecord::RecordNotUnique if a series with the same 'country_code',\
       'frequency', 'series_type', 'basket' as an existing one \
        is tried to be added" do
    assert_raises(ActiveRecord::RecordNotUnique) do
      params = { country_code: "BR",
                country_name: "Brazil",
                frequency: "Monthly",
                series_type: "Nominal",
                basket: "Narrow"
              }
      Series.new(params).save!
      Series.new(params).save!
    end
  end
end
