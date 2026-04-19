class Series < ApplicationRecord
  validates :country_code, :country_name, :frequency, :series_type, :basket, presence: true
end
