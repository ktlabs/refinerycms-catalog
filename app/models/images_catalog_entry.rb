class ImagesCatalogEntry < ActiveRecord::Base

  belongs_to :image
  belongs_to :catalog_entry

  before_save do |image_catalog_entry|
    image_catalog_entry.position = (ImagesCatalogEntry.maximum(:position) || -1) + 1
  end

end

