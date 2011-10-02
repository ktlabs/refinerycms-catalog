class EntryAttributeType < ActiveRecord::Base

  after_create   :create_empty_value
  before_destroy :destroy_nested_resources

  has_many :entry_attribute_type_values
  has_many :entry_attributes
  belongs_to :catalog_type

  validates_presence_of   :name
  validates_uniqueness_of :name

  scope :active, :conditions => { :active => true }

  def title
    name
  end

  private

  def create_empty_value
    empty_value = self.entry_attribute_type_values.build(:value => "empty")
    empty_value.save
  end

  def destroy_nested_resources
    entry_attributes.each do |attribute|
      attribute.destroy
    end

    entry_attribute_type_values.each do |value|
      value.destroy
    end

    EntryAttributeTypeValue.destroy_empty(self)
  end
end

