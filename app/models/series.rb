class Series < ApplicationRecord
  validates :country_code, :country_name, :frequency, :series_type, :basket, presence: true

  before_save :normalize_attributes!

  def normalize_attributes!
    self.country_code = country_code.upcase
    self.country_name = country_name&.downcase
    self.frequency = frequency&.downcase
    self.series_type = series_type&.downcase
    self.basket = basket&.downcase

    nil
  end
end
