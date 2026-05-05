class Series < ApplicationRecord
  has_many :observations

  validates :frequency, :series_type, :basket, :country_code, :country_name, presence: true
  before_save :normalize_attributes!

  def normalize_attributes!
    frequency&.downcase!
    series_type&.downcase!
    basket&.downcase!
    country_code&.upcase!
    country_name&.downcase!

    nil
  end

  def series_ref
    ref = frequency[0] << series_type[0] << basket[0] << country_code
    ref.downcase.to_sym # it could be called before save, downcase for safety
  end
end
