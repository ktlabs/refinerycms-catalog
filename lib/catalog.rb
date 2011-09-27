require 'catalog/version'

unless defined?(::Refinery::Catalog::Engine)
  require File.expand_path('../refinerycms-catalog.rb', __FILE__)
end

