class EntryAttributeType < ActiveRecord::Base

  has_many :entry_attribute_type_values
  has_many :entry_attributes
  belongs_to :catalog_type

  validates_presence_of :name
  validates_uniqueness_of :name

  def title
    name
  end
end

