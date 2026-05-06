Observation.delete_all
Series.delete_all

series_metadata = {
  country_code: {
    CA: "Canada",
    CH: "Switzerland",
    BE: "Belgium",
    AT: "Austria",
    AU: "Australia",
    HK: "Hong Kong SAR",
    GB: "United Kingdom",
    GR: "Greece",
    ES: "Spain",
    DK: "Denmark",
    DE: "Germany",
    CL: "Chile",
    BR: "Brazil",
    BG: "Bulgaria",
    KR: "Korea",
    BA: "Bosnia and Herzegovina",
    AR: "Argentina",
    IT: "Italy",
    JP: "Japan",
    IE: "Ireland",
    HR: "Croatia",
    HU: "Hungary",
    SE: "Sweden",
    SG: "Singapore",
    FR: "France",
    FI: "Finland",
    DZ: "Algeria",
    EE: "Estonia",
    PT: "Portugal",
    CY: "Cyprus",
    NO: "Norway",
    CZ: "Czechia",
    NZ: "New Zealand",
    CN: "China",
    CO: "Colombia",
    NL: "Netherlands",
    MX: "Mexico",
    MY: "Malaysia",
    MK: "North Macedonia",
    MT: "Malta",
    LV: "Latvia",
    MA: "Morocco",
    LT: "Lithuania",
    LU: "Luxembourg",
    IS: "Iceland",
    XM: "Euro area",
    IL: "Israel",
    TW: "Chinese Taipei",
    IN: "India",
    US: "United States",
    ID: "Indonesia",
    SK: "Slovakia",
    TH: "Thailand",
    SI: "Slovenia",
    SA: "Saudi Arabia",
    RS: "Serbia",
    RU: "Russia",
    RO: "Romania",
    PH: "Philippines",
    PL: "Poland",
    PE: "Peru",
    ZA: "South Africa",
    TR: "Türkiye",
    AE: "United Arab Emirates" },
  freq: { m: "monthly" },
  series_type: { n: "nominal", r: "real" },
  basket: { n: "narrow", b: "broad" }
}

# loads series from csv
eer_table = CSV.table("db/seeds/eer- WS_EER_csv_row.csv", headers: true)
series_reference = eer_table.headers.drop(1)

series = []
observations = []

series_reference.each do |series_data|
  series << {
    frequency: series_metadata[:freq][series_data[0].to_sym],
    series_type: series_metadata[:series_type][series_data[1].to_sym],
    basket: series_metadata[:basket][series_data[2].to_sym],
    country_code: series_data.to_s[-2..-1].upcase,
    country_name: series_metadata[:country_code][series_data.to_s[-2..-1].upcase.to_sym].downcase
  }
end

Series.insert_all(series)
Rails.logger.info "#{Series.count} series added to database."

Series.find_each do |series|
  values = eer_table[series.series_ref]
  next unless values

  eer_table[:time_period].each_with_index do |time, index|
    next unless time && values[index]

    observations << {
      series_id: series.id,
      observed_on: "#{time}-01",
      value: values[index]
    }
  end
end

Observation.insert_all(observations)
Rails.logger.info "#{Observation.count} observations added to database."
