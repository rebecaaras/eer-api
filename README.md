# Effective Exchange Rates App

This app aims to provide an _api_ interface to display the [public data](https://data.bis.org/topics/EER/data?selected_ts=BIS%2CWS_EER%2C1.0%255ED.N.N%2BB.IE%2CM.N.N%2BB.IE%2CM.R.N%2BB.IE%2CD%2BM.N.B.IL%2CM.R.B.IL%2BIT%2CD.N.N%2BB.IT%2CM.N%2BR.N.IT%2CM.N.B.IT%2BJP%2CD.N.N%2BB.JP%2CM.N%2BR.N.JP&page_size=100) provided by [BIS](https://data.bis.org).

## What are Effective Exchange Rate Indexes ?

An [EER index](https://en.wikipedia.org/wiki/Effective_exchange_rate) is a measure of the value of a country's currency relative to a basket of foreign currencies over time. The index is calculated by comparing the current EER to a base period, which is usually set to equal 100. If the EER increases over time, it means that the currency is appreciating in value relative to the basket of foreign currencies. If the EER decreases over time, it means that the currency is depreciating in value relative to the basket of foreign currencies.

## Goals & Stack

This is the _backend_ part of the EER API project, you can check the [front-end here](https://github.com/rebecaaras/eer-app). It is mainly meant for my own learning. Some topics I had to approach for this project include (with the respective chosen technologies):

- Basic Databases Design and Setup (Postgres + Rails Active Record)
- API Development (Ruby on Rails)
- Front-end client consuming the API (React + TypeScript)
- Componentization and Responsiveness (I mostly relied on [Shadcn-UI](https://github.com/shadcn-ui/ui))

## Setup

You can access this project at [eer-api.rebecaaras.org](https://eer-api.rebecaaras.org/series) or run it locally:

Clone the repo:

```
git clone https://github.com/rebecaaras/eer-api
cd eer-api
```

Install dependencies, setup db and seed data with:

```
bin/setup
```

Open in browser and enjoy :)

## Example queries:

Query first series: [eer-api.rebecaaras.org/series/1](https://eer-api.rebecaaras.org/series/1)
~~~
{
  "series": {
    "id": 1,
    "basket": "narrow",
    "country_code": "CA",
    "country_name": "canada",
    "frequency": "monthly",
    "series_type": "nominal"
  },
  "data": [
    {
      "date": "1964-01-01",
      "value": "132.69"
    },
    {
      "date": "1964-02-01",
      "value": "132.74"
    },
    {
      "date": "1964-03-01",
      "value": "132.66"
    },
    {
      "date": "1964-04-01",
      "value": "132.62"
    },
...
~~~

Query all series: [eer-api.rebecaaras.org/series](https://eer-api.rebecaaras.org/series)
~~~
[
  {
    "id": 1,
    "basket": "narrow",
    "country_code": "CA",
    "country_name": "canada",
    "created_at": "2026-10-09T16:03:40.014Z",
    "frequency": "monthly",
    "series_type": "nominal",
    "updated_at": "2026-10-09T16:03:40.014Z"
  },
  {
    "id": 2,
    "basket": "narrow",
    "country_code": "CH",
    "country_name": "switzerland",
    "created_at": "2026-10-09T16:03:40.014Z",
    "frequency": "monthly",
    "series_type": "nominal",
    "updated_at": "2026-10-09T16:03:40.014Z"
  },
...
~~~

Filter by country_name (or any other param you want):
[eer-api.rebecaaras.org/series?country_name=spain](https://eer-api.rebecaaras.org/series?country_name=spain)
~~~
[{"id":11,"basket":"narrow","country_code":"ES","country_name":"spain","created_at":"2026-10-09T16:03:40.014Z","frequency":"monthly","series_type":"nominal","updated_at":"2026-10-09T16:03:40.014Z"},{"id":41,"basket":"broad","country_code":"ES","country_name":"spain","created_at":"2026-10-09T16:03:40.014Z","frequency":"monthly","series_type":"nominal","updated_at":"2026-10-09T16:03:40.014Z"},{"id":119,"basket":"narrow","country_code":"ES","country_name":"spain","created_at":"2026-10-09T16:03:40.014Z","frequency":"monthly","series_type":"real","updated_at":"2026-10-09T16:03:40.014Z"},{"id":161,"basket":"broad","country_code":"ES","country_name":"spain","created_at":"2026-10-09T16:03:40.014Z","frequency":"monthly","series_type":"real","updated_at":"2026-10-09T16:03:40.014Z"}]
~~~
