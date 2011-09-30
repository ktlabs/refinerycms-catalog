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
    @catalog_entry = @catalog_type.catalog_entries.build(params[:catalog_entries])
    if @catalog_entry.save
      flash[:notice] = f('flash.created.male', :object => CatalogEntry.human_name)
      render :action => 'index'
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
      render :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @catalog_entry.destroy
    flash[:notice] = t('flash.destroyed.male', :object => CatalogEntry.human_name)
    redirect_to [:admin, @catalog_type]
  end

  protected

  def load_catalog_type
    @catalog_type = CatalogType.find_by_name(params[:catalog_type_id])
  end

  def load_catalog_entry
    @catalog_entry = CatalogEntry.find_by_name(params[:id])
  end
end

