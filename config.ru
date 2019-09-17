# frozen_string_literal: true

require_relative 'autoload'

use AuthMiddleware
use Rack::Reloader, 0
use Rack::Session::Cookie, key: 'rack.session', path: '/', expire_after: 604_800, secret: 'snowden'

run Rack::Cascade.new([Rack::File.new('views'), GameProcess])
