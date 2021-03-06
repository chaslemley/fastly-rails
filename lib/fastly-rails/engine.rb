require 'fastly-rails/active_record/surrogate_key'
require 'fastly-rails/action_controller/cache_control_headers'
require 'fastly-rails/action_controller/surrogate_control_headers'

module FastlyRails
  class Engine < ::Rails::Engine
    isolate_namespace FastlyRails

    config.generators do |g|
      g.test_framework      :mini_test, :spec => true, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'test/factories'
    end

    ActiveSupport.on_load :action_controller do
      ActionController::Base.send :include, FastlyRails::CacheControlHeaders
      ActionController::Base.send :include, FastlyRails::SurrogateControlHeaders
    end

    ActiveSupport.on_load :active_record do
      ActiveRecord::Base.send :include, FastlyRails::SurrogateKey
    end

  end
end
