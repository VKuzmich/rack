# frozen_string_literal: true

I18n.load_path << Dir[File.dirname(__FILE__) + '/locales/*.yml']
config.i18n.fallbacks = [I18n.default_locale]
