# frozen_string_literal: true

require_relative '../autoload'

class GameProcess
  include CodebreakerVk
  include DataUtils

  URLS = {
    main: '/',
    rules: '/rules',
    statistics: '/statistics',
    start: '/start',
    play_again: '/play_again',
    check: '/check',
    lose: '/lose',
    game: '/game',
    win: '/win',
    show_hint: '/show_hint',
  }.freeze

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    case @request.path
    when URLS[:main]        then main
    when URLS[:rules]       then rules
    when URLS[:statistics]  then statistic
    when URLS[:start]       then start
    when URLS[:play_again]  then play_again
    when URLS[:check]       then check
    when URLS[:lose]        then lose
    when URLS[:game]        then game
    when URLS[:win]         then win
    when URLS[:show_hint]   then show_hint
    else Rack::Response.new('Not Found', 404)
    end
  end

  def rules
    Rack::Response.new(render('rules.html.erb'))
  end

  def statistic
    Rack::Response.new(render('statistics.html.erb'))
  end

  def main
    return redirect(URLS[:game]) if @request.session.key?(:game)

    Rack::Response.new(render('menu.html.erb'))
  end

  def play_again
    @request.session.delete(:game)

    redirect(URLS[:main])
  end

  def start
    start_redirect || start_initialize
  end

  def game
    if @request.session[:game].attempts.zero?
      redirect(URLS[:lose])
    elsif @request.session[:game].win?
      redirect(URLS[:win])
    else
      Rack::Response.new(render('game.html.erb'))
    end
  end

  def show_hint
    @request.session[:hints] << @request.session[:game].use_hint if @request.session[:game].hints.positive?
    redirect(URLS[:game])
  end

  def check
    return redirect unless @request.params.key?('number')

    @request.session[:result] = @request.session[:game].check(@request.params['number'])

    return redirect(URLS[:game]) unless @request.session[:game].win?

    save(summary) unless @request.session[:save]
    redirect(URLS[:win])
  end

  def lose
    lose_redirect || Rack::Response.new(render('lose.html.erb'))
  end

  def win
    win_redirect || Rack::Response.new(render('win.html.erb'))
  end

  def render(template)
    path = File.expand_path("../../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def redirect(address = '')
    Rack::Response.new { |response| response.redirect(address.to_s) }
  end

  def summary
    attempts_total = CodebreakerVk::Game::DIFFICULTY_LEVEL[@request.session[:game].difficulty][:attempts]
    hints_total = CodebreakerVk::Game::DIFFICULTY_LEVEL[@request.session[:game].difficulty][:hints]
    {
      name: @request.session[:game].name,
      difficulty: @request.session[:game].difficulty,
      attempts_total: attempts_total,
      attempts_used: attempts_total - @request.session[:game].attempts,
      hints_total: hints_total,
      hints_used: hints_total - @request.session[:game].hints,
      date: Time.now
    }
  end

  def stats
    return [] unless File.exist?('spec/fixtures/seed.yaml')

    load.sort_by { |row| [row.hints_total, row.attempts_used] }
  end

  def start_initialize
    default_setting
    @request.session[:game] = Game.new(name: @request['username'], difficulty: @request['difficulty'].to_sym)
    redirect(URLS[:game])
  end

  def default_setting
    @request.session.merge!(
      result: nil,
      hints: [],
      save: false
    )
  end

  def start_redirect
    redirect unless @request.params.key?('username')
  end

  def lose_redirect
    redirect(URLS[:game]) if @request.session[:game].attempts.positive?
  end

  def win_redirect
    redirect(URLS[:game]) unless @request.session[:game].win?
  end
end
