require 'simplecov'
require 'rack/test'
require_relative '../autoload'

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
end
