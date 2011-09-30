class Admin::TypesController < Admin::BaseController

  before_filter :load_catalog_type
  before_filter :load_entry_attribute_type, :only => [:show, :edit, :update, :destroy]

  def index
    @entry_attribute_types = @catalog_type.entry_attribute_types
  end

  def create
    @entry_attribute_type = @catalog_type.entry_attribute_types.build(params[:entry_attribute_type])
    if @entry_attribute_type.save
      flash[:notice] = t('flash.created.male', :object => EntryAttributeType.human_name)
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def show

  end

  def new
    @entry_attribute_type = EntryAttributeType.new
  end

  def edit

  end

  def update
    if @entry_attribute_type.update_attributes(params[:entry_attribute_type])
      flash[:notice] = t('flash.updated.male', :object => EntryAttributeType.human_name)
      render :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @entry_attribute_type.destroy
    flash[:notice] = t('flash.destroyed.male', :object => EntryAttributeType.human_name)
    redirect_to [:admin, @catalog_type]
  end

  protected

  def load_catalog_type
    @catalog_type = CatalogType.find_by_name(params[:catalog_type_id])
  end

  def load_entry_attribute_type
    @entry_attribute_type = EntryAttributeType.find(params[:id])
  end
end

