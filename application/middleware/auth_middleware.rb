# frozen_string_literal: true

class AuthMiddleware
  GAME_LINKS = ['/check', '/show_hint', '/win', '/lose'].freeze

  def initialize(app, status = 302)
    @app = app
    @status = status
  end

  def call(env)
    @request = Rack::Request.new(env)

    return [@status, { 'Location' => GameProcess::URLS[:game] }, ['']] if authenticated? && game_links?

    @app.call(env)
  end

  def authenticated?
    @request.session.key?(:game) && @request.session.key?('username')
  end

  def game_links?
    GAME_LINKS.include?(@request.path)
  end
end
