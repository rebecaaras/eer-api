require "test_helper"

# Null violations
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
  # Not unique violation
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

  # Check violations
  test "should not accept frequency different of 'monthly'" do
    assert_raises(ActiveRecord::CheckViolation) do
      params = { country_code: "CH",
                country_name: "Switzerland",
                frequency: "daily",
                series_type: "Nominal",
                basket: "Narrow"
              }
      Series.new(params).save!
    end
  end

  test "should not accept series_type different of 'nominal' or 'real'" do
    assert_raises(ActiveRecord::CheckViolation) do
      params = { country_code: "CH",
                country_name: "Switzerland",
                frequency: "Monthly",
                series_type: "nominala",
                basket: "Narrow"
              }
      Series.new(params).save!
    end
  end

  test "should not accept basket different of 'narrow' or 'broad'" do
    assert_raises(ActiveRecord::CheckViolation) do
      params = { country_code: "CH",
                country_name: "Switzerland",
                frequency: "Monthly",
                series_type: "nominal",
                basket: "Narrowww"
              }
      Series.new(params).save!
    end
  end

  # Normalization
  test "should normalize all fields" do
    params = { country_code: "ch",
                country_name: "Switzerland",
                frequency: "MonThly",
                series_type: "NOMINAL",
                basket: "Narrow"
              }
    series = Series.new(params)
    series.save!

    assert_equal params[:country_code].upcase, series.country_code, "country_code is not upcase"
    assert_equal params[:country_name].downcase, series.country_name, "country_name is not downcase"
    assert_equal params[:frequency].downcase, series.frequency, "frequency is not downcase"
    assert_equal params[:series_type].downcase, series.series_type, "series_type is not downcase"
    assert_equal params[:basket].downcase, series.basket, "basket is not downcase"
  end
end
