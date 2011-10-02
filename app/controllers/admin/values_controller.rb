class Admin::ValuesController < Admin::BaseController

  before_filter :load_catalog_type_and_entry_attribute_type
  before_filter :load_entry_attribute_type_value, :only => [:show, :edit, :update, :destroy]

  def index
    @entry_attribute_type_values = @entry_attribute_type.entry_attribute_type_values
  end

  def create
    @entry_attribute_type_value = @entry_attribute_type.entry_attribute_type_values.build(params[:entry_attribute_type_value])
    if @entry_attribute_type_value.save
      flash[:notice] = t('flash.created.male', :object => EntryAttributeTypeValue.human_name)
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def show

  end

  def new
    @entry_attribute_type_value = EntryAttributeTypeValue.new
  end

  def edit

  end

  def update
    if @entry_attribute_type_value.update_attributes(params[:entry_attribute_type_value])
      flash[:notice] = t('flash.updated.male', :object => EntryAttributeTypeValue.human_name)
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @entry_attribute_type_value.destroy
      flash[:notice] = t('flash.destroyed.male', :object => EntryAttributeTypeValue.human_name)
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  protected

  def load_catalog_type_and_entry_attribute_type
    @catalog_type         = CatalogType.find_by_name(params[:catalog_type_id])
    @entry_attribute_type = EntryAttributeType.find(params[:entry_attribute_type_id])
  end

  def load_entry_attribute_type_value
    @entry_attribute_type_value = EntryAttributeTypeValue.find(params[:id])
  end
end

