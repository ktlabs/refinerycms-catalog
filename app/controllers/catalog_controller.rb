class CatalogController < ApplicationController

  before_filter :load_page, :only => [:index, :show, :empty]

  def index
    @catalog_entries = CatalogEntry.all
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
    result = {}

    type_names = ActiveSupport::JSON.decode(params[:attribute_types])
    keys = EntryAttributeType.where(:name => type_names)
    keys.each do |key|
      result["by_#{key.name}"] = EntryAttributeTypeValue.where(:entry_attribute => key).map do |v| {:name => v.value} end
    end
  end

protected

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

