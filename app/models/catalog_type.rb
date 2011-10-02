class CatalogType < ActiveRecord::Base

  before_destroy :destroy_nested_resources

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

  private

  def destroy_nested_resources
    entry_attributes.each do |attribute|
      attribute.destroy
    end

    entry_attribute_types.each do |attribute_type|
      attribute_type.destroy
    end

    catalog_entries.each do |entry|
      entry.destroy
    end
  end
end

