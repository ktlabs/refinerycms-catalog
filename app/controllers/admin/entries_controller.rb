class Admin::EntriesController < Admin::BaseController

#ToDo:
#  crudify :catalog_entry,
#          :order => 'lft ASC',
#          :conditions => {:parent_id => nil},
#          :sortable => true

  before_filter :load_catalog_type
  before_filter :load_catalog_entry, :only => [:show, :edit, :update, :destroy]

  def index
    @catalog_entries = @catalog_type.catalog_entries
  end

  def create
    @catalog_entry = @catalog_type.catalog_entries.build(params[:catalog_entry])
    if @catalog_entry.save
      @catalog_type.entry_attribute_types.each do |attribute_type|
        entry_attribute = @catalog_entry.entry_attributes.build(:catalog_type => @catalog_type,
                                              :entry_attribute_type => attribute_type,
                                              :entry_attribute_type_value => EntryAttributeTypeValue.empty_value(attribute_type))
        entry_attribute.save
      end

      flash[:notice] = t('flash.created.male', :object => CatalogEntry.human_name)
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def show

  end

  def new
    @catalog_entry = CatalogEntry.new
  end

  def edit

  end

  def update
    if @catalog_entry.update_attributes(params[:catalog_entry])
      flash[:notice] = t('flash.updated.male', :object => CatalogEntry.human_name)
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @catalog_entry.destroy
    flash[:notice] = t('flash.destroyed.male', :object => CatalogEntry.human_name)
    redirect_to :action => 'index'
  end

  protected

  def load_catalog_type
    @catalog_type = CatalogType.find_by_name(params[:catalog_type_id])
  end

  def load_catalog_entry
    @catalog_entry = CatalogEntry.find(params[:id])
  end
end

