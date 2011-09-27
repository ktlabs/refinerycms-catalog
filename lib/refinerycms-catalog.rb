require 'refinery'

module Refinery
  module Catalog

    class << self
      def multi_level?
        RefinerySetting.table_exists? and RefinerySetting.find_or_set(:multi_level_catalog, false, {
          :callback_proc_as_string => %q{::ActionController::Routing::Routes.reload!},
          :restricted => true
        })
      end
    end

    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "catalog"
          plugin.version = ::Refinery::Catalog.version
          plugin.menu_match = /admin\/catalog(_entries)?/
          plugin.activity = {
            :class => CatalogEntry
          }
        end unless Refinery::Plugins.registered.names.include?('catalog')
      end
    end
  end
end

require File.expand_path('../catalog', __FILE__)

