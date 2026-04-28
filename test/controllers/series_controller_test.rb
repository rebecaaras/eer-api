require "test_helper"

class SeriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @series = series(:be)
  end

  test "should get index" do
    get series_url, as: :json
    assert_response :success
  end

  test "should create series" do
    assert_difference("series.count") do
      post series_url, params: { series: { country_name: @series.country_name, country_code: @series.country_name, basket: @series.basket, frequency: @series.frequency, series_type: @series.series_type } }, as: :json
    end

    assert_response :created
  end

  test "should show series" do
    get series_url(@series), as: :json
    assert_response :success
  end

  test "should update series" do
    patch series_url(@series), params: { series: { country_code: "BG" } }, as: :json
    assert_response :success
  end

  test "should destroy series" do
    assert_difference("series.count", -1) do
      delete series_url(@series), as: :json
    end

    assert_response :no_content
  end
end
