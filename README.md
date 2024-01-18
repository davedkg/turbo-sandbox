# Hotwire Weather Forecast

Display current, high, and low temperatures for a given address.

## Disclaimer

config/master.key was left in this repository to make testing easier

## UI

### Initial Screen

![Forecast](docs/forecast-empty.png?raw=true)

### Forecast Screen

![Forecast](docs/forecast.png?raw=true)

### Cached Forecast Screen

![Forecast2](docs/forecast-cached.png?raw=true)

## Local Setup

```bash
$ bundle
$ rspec
$ rails s
$ open http://localhost:3000/
```

## Architecture

### Forecast Model

#### Input Attributes
- address
- zip_code
- country

#### Calculated Attributes
- temperature_current
- temperature_max
- temperature_min
- cached?

### Cache

This app relys on a memory cache for development purposes.  In production, it's recommended to add a shared memory cache accessible across all workers.

### Performance

Using TurboFrames to render partial page updates. Storing forecasts in a memory cache instead of a database.

## Improvements

- More thorough error handling with the forecast form. Widget assumes Google's Maps API works perfectly everytime and could easily break if user hacks it.
