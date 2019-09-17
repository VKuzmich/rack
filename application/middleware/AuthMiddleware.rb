# frozen_string_literal: true

class AuthMiddleware
  def initialize(app, status = 302)
    @app = app
    @status = status
  end

  def call(env)
    @request = Rack::Request.new(env)

    return [@status, { 'Location' => GameProcess::URLS[:game] }, ['']] if @request.session.key?(:main)

    @app.call(env)
  end
end
