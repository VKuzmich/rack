# frozen_string_literal: true

class AuthMiddleware
  AUTH_PATHS = %w[/check /win /lose].freeze

  def initialize(app, status = 302)
    @app = app
    @status = status
  end

  def call(env)
    @request = Rack::Request.new(env)

    return [@status, { 'Location' => GameProcess::URLS[:root] }, ['']] if !authenticated? && auth_paths?

    @app.call(env)
  end

  def authenticated?
    @request.session.key?(:game)
  end

  def auth_paths?
    AUTH_PATHS.include?(@request.path)
  end
end
