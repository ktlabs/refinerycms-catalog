class EntryAttributeTypeValue < ActiveRecord::Base

  belongs_to :entry_attribute_type
  has_many :entry_attributes

end

