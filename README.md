# Flinks

A ruby client for the [Flinks](https://flinks.io) API.

[![Build Status](https://travis-ci.org/phildionne/flinks.svg?branch=master)](https://travis-ci.org/phildionne/flinks)
[![Gem Version](https://badge.fury.io/rb/flinks.svg)](https://badge.fury.io/rb/flinks)
[![Maintainability](https://api.codeclimate.com/v1/badges/f7714d9a2a4bd8a58bff/maintainability)](https://codeclimate.com/github/phildionne/flinks/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f7714d9a2a4bd8a58bff/test_coverage)](https://codeclimate.com/github/phildionne/flinks/test_coverage)

## Installation

```bash
gem install flinks
```

Or with bundler:

```ruby
gem 'flinks', require: 'flinks'
```

## Usage

This library needs to be configured with your API customer ID.

```ruby
flinks = Flinks.new(customer_id: ENV['FLINKS_CUSTOMER_ID'])
```

Configure `on_error` to catch API requests returning a 400..599 HTTP status.

```ruby
flinks = Flinks.new({
  customer_id: ENV['FLINKS_CUSTOMER_ID'],
  on_error: Proc.new do |status, message, body|
    p [status, message, body]
  end
})
```

Configure `debug` to print every API responses.

```ruby
flinks = Flinks.new({
  customer_id: ENV['FLINKS_CUSTOMER_ID'],
  debug: true
})
```

### Endpoints

#### Authorize

- `authorize(login_id:, options:)`
- `authorize_with_credentials(username:, password:, institution:, options:)`
- `authorize_multiple(login_ids:)`

#### Account

- `accounts_summary(request_id:, options:)`
- `accounts_summary_async(request_id:)`
- `accounts_detail(request_id:, options:)`
- `accounts_detail_async(request_id:)`

#### Card

- `delete_card(card_id:)`

#### Refresh

- `activate_scheduled_refresh(login_id:)`
- `deactivate_scheduled_refresh(login_id:)`
- `set_scheduled_refresh(activated, login_id:)`

#### Statement

- `statements(options:)`
- `statements_async(request_id:)`

## Documentation

See the [API docs](https://sandbox-api.flinks.io).

## Supported Ruby versions

- MRI 2.3
- MRI 2.4
- MRI 2.5

## Development

Run all tests:

```bash
bundle exec rspec
```

## License

[MIT](LICENSE.txt)
