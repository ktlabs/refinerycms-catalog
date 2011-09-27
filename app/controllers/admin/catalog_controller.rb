class Admin::CatalogController < Admin::BaseController

  crudify :catalog_entry,
          :order => 'lft ASC',
          :conditions => {:parent_id => nil},
          :sortable => true

end

