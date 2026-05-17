require "test_helper"

class SeriesControllerTest < ActionDispatch::IntegrationTest
  test "should show all series" do
    get "/series"

    body = JSON.parse(response.body)

    assert body.count, 4
    assert_response :success
  end

  test "should filter by series type" do
    params = { series_type: "nominal" }
    get "/series", params: { series_type: params[:series_type] }

    body = JSON.parse(response.body)

    assert_response :success
    assert body.all? { |s| s["series_type"] === params[:series_type] }
    assert body.count 2
  end

  test "should create series" do
    params = { country_name: "country x", country_code: "XX", basket: "narrow", frequency: "monthly", series_type: "nominal" }
    assert_difference("Series.count", 1) do
      post "/series", params: { series: params }
    end
    assert_response :created
  end

  test "should update series" do
    id = Series.first.id
    patch "/series/#{id}", params: { series: { country_code: "BW" } }, as: :json

    assert response.body["country_code"], "BW"
    assert_response :success
  end

  test "should destroy series" do
    id = Series.first.id
    assert_difference("Series.count", -1) do
      delete "/series/#{id}", as: :json
    end
    assert_response :no_content
  end
end
