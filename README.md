# Flinks

A ruby client for the [Flinks](https://flinks.io) API.

[![Dependency Status](https://gemnasium.com/badges/github.com/phildionne/flinks.svg)](https://gemnasium.com/github.com/phildionne/flinks)
[![Gem Version](https://badge.fury.io/rb/flinks.svg)](https://badge.fury.io/rb/flinks)

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
- `set_scheduled_refresh(login_id:)`

#### Statement

- `statements(request_id:, options:)`
- `statements_async(request_id:)`

## Documentation

See the [API docs](https://sandbox-api.flinks.io).

## Development

Run all tests:

```bash
bundle exec rspec
```
