class CatalogController < ApplicationController

  before_filter :load_page, :only => [:index, :show, :empty]

  def index
    composition = EntryAttributeType.where(:name => 'composition', :catalog_type_id => fabrics_catalog.id).first
    color = EntryAttributeType.where(:name => 'color', :catalog_type_id => fabrics_catalog.id).first
    manufacturer = EntryAttributeType.where(:name => 'manufacturer', :catalog_type_id => fabrics_catalog.id).first

    values = {}
    values["composition"] = EntryAttributeTypeValue.where(
      :entry_attribute_type_id => composition.id).delete_if do |x| x.value == "empty" end
    values["color"] = EntryAttributeTypeValue.where(
      :entry_attribute_type_id => color.id).delete_if do |x| x.value == "empty" end
    values["manufacturer"] = EntryAttributeTypeValue.where(
      :entry_attribute_type_id => manufacturer.id).delete_if do |x| x.value == "empty" end

    @filters = values
  end

  def show
    begin
      @master_entry = if params[:id]
        CatalogEntry.find(params[:id])
      else
        CatalogEntry.where(:parent_id => nil).first
      end

      if ::Refinery::Catalog.multi_level?
        multi_level
      else
        single_level
      end

      begin
        image_index = (params[:image_id].presence || '0').to_i
        @image = @catalog_entry.images[image_index]
      rescue
        render :action => "empty"
      end
    rescue
      error_404
    end

    render :partial => "main_image", :layout => false if request.xhr?
  end

  def filters

  end

  def search

    applied_filters = params

    entries_by_composition = EntryAttribute.where(
      :entry_attribute_type_value_id => array_from_hash(applied_filters[:composition]).map do
          |x| x["id"]
        end).map do |x| x.catalog_entry end

    entries_by_color = EntryAttribute.where(
      :entry_attribute_type_value_id => array_from_hash(applied_filters[:color]).map do
          |x| x["id"]
        end).map do |x| x.catalog_entry end

    entries_by_manufacturer = EntryAttribute.where(
      :entry_attribute_type_value_id => array_from_hash(applied_filters[:manufacturer]).map do
          |x| x["id"]
        end).map do |x| x.catalog_entry end


    entries = []
    if entries_by_composition.empty?
      if entries_by_color.empty?
        entries = entries_by_manufacturer
      else
        entries = entries_by_color
      end
    else
      entries = entries_by_composition
    end

    if not entries_by_composition.empty?
      entries = entries & entries_by_composition
    end

    if not entries_by_color.empty?
      entries = entries & entries_by_color
    end

    if not entries_by_manufacturer.empty?
      entries = entries & entries_by_manufacturer
    end


    render :json => (entries).uniq.to_json(
      :methods => [:color, :manufacturer, :composition, :article, :price])

  end

protected

  def array_from_hash(h)
    return h unless h.is_a? Hash

    all_numbers = h.keys.all? { |k| k.to_i.to_s == k }
    if all_numbers
        h.keys.sort_by{ |k| k.to_i }.map{ |i| array_from_hash(h[i]) }
    else
        h.each do |k, v|
                h[k] = array_from_hash(v)
        end
    end
end


  def fabrics_catalog
    return CatalogType.find_by_name('fabrics')
  end

  def entries_by_catalog_type(catalog_name)
    CatalogType.find_by_name(catalog_name).catalog_entries
  end

  def multi_level
    @catalog_entries = @master_entry.children
    @catalog_entry = if params[:catalog_id]
      @catalog_entries.find(params[:catalog_id])
    else
      @catalog_entries.first
    end
  end

  def single_level
    @catalog_entries = CatalogEntry.all
    @catalog_entry = @master_entry
  end

  def load_page
    @page = Page.find_by_link_url('/catalog', :include => [:parts])
  end

end
