class SeriesController < ApplicationController
  before_action :set_series, only: %i[ show update destroy ]

  # GET /series
  def index
    @series = Series.all

    render json: @series
  end

  # GET /series/1
  def show
    render json: {
      series: @series.as_json(only: [
        :id, :basket, :country_code, :country_name, :frequency, :series_type
      ]),
      data: @series.observations
                  .order(:observed_on)
                  .map { |o| { date: o.observed_on, value: o.value } }
    }
  end

  # POST /series
  def create
    @series = Series.new(series_params)
      if @series.save
        render json: @series, status: :created, location: @series
      else
        render json: @series.errors, status: :unprocessable_content
      end
  end

  # PATCH/PUT /series/1
  def update
    if @series.update(series_params)
      render json: @series
    else
      render json: @series.errors, status: :unprocessable_content
    end
  end

  # DELETE /series/1
  def destroy
    @series.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_series
      @series = Series.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def series_params
      params.expect(series: [ :country_code, :country_name, :basket, :frequency, :series_type ])
    end
end
