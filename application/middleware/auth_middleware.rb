# frozen_string_literal: true

class AuthMiddleware
  AUTH_PATHS = ['/check', '/win', '/lose'].freeze
  PUBLIC_PATHS = ['/', '/rules', '/statistics'].freeze

  def initialize(app, status = 302)
    @app = app
    @status = status
  end

  def call(env)
    @request = Rack::Request.new(env)

    return [@status, { 'Location' => GameProcess::URLS[:root] }, ['']] if !authenticated? && auth_paths?

    return [@status, { 'Location' => GameProcess::URLS[:game] }, ['']] if authenticated? && public_paths?

    @app.call(env)
  end

  def authenticated?
    @request.session.key?(:game)
  end

  def auth_paths?
    AUTH_PATHS.include?(@request.path)
  end

  def public_paths?
    PUBLIC_PATHS.include?(@request.path)
  end
end
