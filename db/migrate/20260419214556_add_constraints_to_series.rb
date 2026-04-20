class AddConstraintsToSeries < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      ALTER TABLE series ALTER COLUMN id TYPE integer;
      ALTER TABLE series ALTER COLUMN country_code TYPE varchar(2);
      ALTER TABLE series ALTER COLUMN country_name TYPE varchar(100);
      ALTER TABLE series ALTER COLUMN basket TYPE varchar(20);
      ALTER TABLE series ALTER COLUMN frequency TYPE varchar(20);
      ALTER TABLE series ALTER COLUMN series_type TYPE varchar(20);

      ALTER TABLE series ADD CONSTRAINT basket_valid CHECK(basket IN ('narrow', 'broad'));
      ALTER TABLE series ADD CONSTRAINT country_code_uppercase CHECK(country_code = UPPER(country_code));
      ALTER TABLE series ADD CONSTRAINT country_name_lowercase CHECK(country_name = LOWER(country_name));
      ALTER TABLE series ADD CONSTRAINT frequency_valid CHECK(frequency IN ('monthly'));
      ALTER TABLE series ADD CONSTRAINT series_type_valid CHECK(series_type IN ('nominal', 'real'));
      ALTER TABLE series ADD CONSTRAINT unique_series UNIQUE (country_code, basket, frequency, series_type);
    SQL
  end

  def down
    execute <<~SQL
      ALTER TABLE series ALTER COLUMN id TYPE bigint;
      ALTER TABLE series ALTER COLUMN country_code TYPE varchar;
      ALTER TABLE series ALTER COLUMN country_name TYPE varchar;
      ALTER TABLE series ALTER COLUMN basket TYPE varchar;
      ALTER TABLE series ALTER COLUMN frequency TYPE varchar;
      ALTER TABLE series ALTER COLUMN series_type TYPE varchar;

      ALTER TABLE series DROP CONSTRAINT IF EXISTS basket_valid;
      ALTER TABLE series DROP CONSTRAINT IF EXISTS country_code_uppercase;
      ALTER TABLE series DROP CONSTRAINT IF EXISTS country_name_lowercase;
      ALTER TABLE series DROP CONSTRAINT IF EXISTS frequency_valid;
      ALTER TABLE series DROP CONSTRAINT IF EXISTS series_type_valid;
      ALTER TABLE series DROP CONSTRAINT IF EXISTS unique_series;
    SQL
  end
end
