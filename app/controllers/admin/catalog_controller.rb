class Admin::CatalogController < Admin::BaseController

  before_filter :attributes_with_empty_values, :only => [:index, :empty_values]

  crudify :catalog_type

  def empty_values

  end

  private

  def attributes_with_empty_values
    @attributes_with_empty_values ||= EntryAttribute.joins(:entry_attribute_type_value).where("entry_attribute_type_values.value = ?", "empty")
  end

end

