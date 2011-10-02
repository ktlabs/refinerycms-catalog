class EntryAttributeTypeValue < ActiveRecord::Base

  before_save    :check_empty_value_modification
  before_destroy :check_empty_value_destroy
  before_destroy :replace_destroyed_value_by_empty

  belongs_to :entry_attribute_type
  has_many :entry_attributes

  validates :value, :presence => true

  def self.empty_value(entry_attribute_type)
    EntryAttributeTypeValue.where(:value => "empty", :entry_attribute_type_id => entry_attribute_type.id).first
  end

  def self.destroy_empty(entry_attribute_type)
    empty_value = self.empty_value(entry_attribute_type)
    @force_empty_value_destroy = true
    empty_value.destroy
  end

  protected

  def check_empty_value_modification
    if self.value_changed? && self.value_was == "empty"
      self.errors.add("entry_attribute_type_value", ", could not modify 'empty' value")
      return false
    end
  end

  def check_empty_value_destroy
    if !@force_empty_value_destroy && self.value == "empty"
      self.errors.add("entry_attribute_type_value", ", could not delete 'empty' value")
      return false
    end
  end

  def replace_destroyed_value_by_empty
    unless self.value == "empty"
      entry_attributes.each do |attribute|
        attribute.entry_attribute_type_value = EntryAttributeTypeValue.empty_value
        attribute.save
      end
    end
  end
end

