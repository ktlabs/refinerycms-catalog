class Admin::AttributesController < Admin::BaseController

  before_filter :load_catalog_type_and_catalog_entry
  before_filter :load_entry_attribute, :only => [:show, :edit, :update, :destroy]

  def index
    @entry_attribute = @catalog_entry.entry_attributes
  end

  def create
    @entry_attribute = @catalog_entry.entry_attributes.build(params[:entry_attribute])
    if @entry_attribute.save
      flash[:notice] = t('flash.created.male', :object => EntryAttribute.human_name)
      render :action => 'index'
    else
      render :action => 'new'
    end
  end

  def show

  end

  def new
    @entry_attribute = EntryAttribute.new
  end

  def edit

  end

  def update
    if @entry_attribute.update_attributes(params[:entry_attribute])
      flash[:notice] = t('flash.updated.male', :object => EntryAttribute.human_name)
      render :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @entry_attribute.destroy
    flash[:notice] = t('flash.destroyed.male', :object => EntryAttribute.human_name)
    redirect_to [:admin, @catalog_entry]
  end

  protected

  def load_catalog_type_and_catalog_entry
    @catalog_type  = CatalogType.find_by_name(params[:catalog_type_id])
    @catalog_entry = CatalogEntry.find_by_name(params[:catalog_entry_id])
  end

  def load_entry_attribute
    @entry_attribute = EntryAttribute.find(params[:id])
  end
end

