Gem::Specification.new do |s|
  s.name              = %q{refinerycms-catalog}
  s.version           = %q{0.9.9}
  s.description       = %q{A really straightforward open source Ruby on Rails catalog plugin designed for integration with RefineryCMS}
  s.date              = %q{2011-09-29}
  s.summary           = %q{Ruby on Rails catalog plugin for RefineryCMS.}
  s.email             = %q{info@refinerycms.com}
  s.homepage          = %q{http://refinerycms.com}
  s.authors           = ['Resolve Digital']
  s.require_paths     = %w(lib)

  s.add_dependency    'refinerycms', '>= 0.9.9'

  s.files             = [
    'readme.md',
    'license.md',
    'app/helpers',
    'app/helpers/catalog_helper.rb',
    'app/controllers',
    'app/controllers/catalog_controller.rb',
    'app/controllers/admin',
    'app/controllers/admin/types_controller.rb',
    'app/controllers/admin/entries_controller.rb',
    'app/controllers/admin/attributes_controller.rb',
    'app/controllers/admin/catalog_controller.rb',
    'app/controllers/admin/values_controller.rb',
    'app/models',
    'app/models/entry_attributes.rb',
    'app/models/catalog_entry.rb',
    'app/models/entry_attribute_type_value.rb',
    'app/models/catalog_type.rb',
    'app/models/images_catalog_entry.rb',
    'app/models/entry_attribute_type.rb',
    'app/views',
    'app/views/catalog',
    'app/views/catalog/show.html.erb',
    'app/views/catalog/_main_image.html.erb',
    'app/views/catalog/index.html.erb',
    'app/views/catalog/empty.html.erb',
    'app/views/admin',
    'app/views/admin/values',
    'app/views/admin/values/_list.html.erb',
    'app/views/admin/values/_form.html.erb',
    'app/views/admin/values/index.html.erb',
    'app/views/admin/values/new.html.erb',
    'app/views/admin/values/edit.html.erb',
    'app/views/admin/entries',
    'app/views/admin/entries/_list.html.erb',
    'app/views/admin/entries/_form.html.erb',
    'app/views/admin/entries/index.html.erb',
    'app/views/admin/entries/_sortable_list.html.erb',
    'app/views/admin/entries/new.html.erb',
    'app/views/admin/entries/edit.html.erb',
    'app/views/admin/catalog',
    'app/views/admin/catalog/_list.html.erb',
    'app/views/admin/catalog/_form.html.erb',
    'app/views/admin/catalog/index.html.erb',
    'app/views/admin/catalog/new.html.erb',
    'app/views/admin/catalog/edit.html.erb',
    'app/views/admin/types',
    'app/views/admin/types/_list.html.erb',
    'app/views/admin/types/_form.html.erb',
    'app/views/admin/types/index.html.erb',
    'app/views/admin/types/new.html.erb',
    'app/views/admin/types/edit.html.erb',
    'app/views/admin/attributes',
    'app/views/admin/attributes/_list.html.erb',
    'app/views/admin/attributes/_form.html.erb',
    'app/views/admin/attributes/index.html.erb',
    'app/views/admin/attributes/edit.html.erb',
    'config/locales',
    'config/locales/en.yml',
    'config/locales/ru.yml',
    'config/routes.rb',
    'lib/gemspec.rb',
    'lib/catalog',
    'lib/catalog/version.rb',
    'lib/generators',
    'lib/generators/refinerycms_catalog',
    'lib/generators/refinerycms_catalog/templates',
    'lib/generators/refinerycms_catalog/templates/db',
    'lib/generators/refinerycms_catalog/templates/db/seeds',
    'lib/generators/refinerycms_catalog/templates/db/seeds/catalog.rb',
    'lib/generators/refinerycms_catalog/templates/db/migrate',
    'lib/generators/refinerycms_catalog/templates/db/migrate/1_create_structure_for_catalog.rb',
    'lib/generators/refinerycms_catalog/templates/db/migrate/2_create_structure_for_catalog_type_and_attributes.rb',
    'lib/generators/refinerycms_catalog/refinerycms_catalog_generator.rb',
    'lib/refinerycms-catalog.rb',
    'lib/catalog.rb',
    'public/stylesheets',
    'public/stylesheets/catalog.css',
    'public/javascripts',
    'public/javascripts/catalog.js'
  ]
  
end
