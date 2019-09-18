# frozen_string_literal: true

class AuthMiddleware
  def initialize(app, status = 302)
    @app = app
    @status = status
  end

  def call(env)
    @request = Rack::Request.new(env)

    return [@status, { 'Location' => GameProcess::URLS[:game] }, ['']] if authenticated?

    @app.call(env)
  end

  def authenticated?
    @request.session.key?(:root) && @request.session.key?('username')
  end
end
