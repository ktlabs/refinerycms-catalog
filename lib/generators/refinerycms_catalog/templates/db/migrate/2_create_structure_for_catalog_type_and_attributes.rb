class CreateStructureForCatalogTypeAndAttributes < ActiveRecord::Migration

  def self.up
    create_table :catalog_types, :force => true do |t|
      t.string   :name
    end

    add_column :catalog_entries, :catalog_type_id, :integer

    create_table :entry_attribute_types do |t|
      t.integer :catalog_type_id
      t.string  :name
      t.boolean :active
    end

    create_table :entry_attribute_type_values do |t|
      t.integer :entry_attribute_type_id
      t.string  :value
    end

    create_table :entry_attributes do |t|
      t.integer :catalog_type_id
      t.integer :catalog_entry_id
      t.integer :entry_attribute_type_id
      t.integer :entry_attribute_type_value_id
    end
  end

  def self.down
    drop_table    :entry_attributes
    drop_table    :entry_attribute_type_values
    drop_table    :entry_attribute_types
    remove_column :catalog_entries, :catalog_type_id
    drop_table    :catalog_types
  end

end

