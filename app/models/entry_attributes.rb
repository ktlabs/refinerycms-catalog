class EntryAttribute < ActiveRecord::Base

  belongs_to :catalog_type
  belongs_to :catalog_entry
  belongs_to :entry_attribute_type
  belongs_to :entry_attribute_type_value

end

