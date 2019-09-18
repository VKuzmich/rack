# frozen_string_literal: true

require 'i18n'
require 'yaml'
require_relative 'application/config/i18n'
require 'codebreaker_vk'
require 'pry'
require 'rack'

require_relative 'application/data_utils'
require_relative 'application/table_row'
require_relative 'application/game_process'
require_relative 'application/middleware/auth_middleware'
