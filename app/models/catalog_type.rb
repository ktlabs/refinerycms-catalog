class CatalogType < ActiveRecord::Base

  has_many :catalog_entry
  has_many :entry_attributes
  has_many :entry_attribute_types

  validates_presence_of :name
  validates_uniqueness_of :name

end

