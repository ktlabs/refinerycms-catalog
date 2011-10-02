class CatalogType < ActiveRecord::Base

  has_many :catalog_entries
  has_many :entry_attributes
  has_many :entry_attribute_types

  validates_presence_of :name
  validates_uniqueness_of :name

  # call to gems included in refinery.
  has_friendly_id :name, :use_slug => true

  def title
    name
  end
end

