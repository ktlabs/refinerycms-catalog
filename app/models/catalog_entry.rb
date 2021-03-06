class CatalogEntry < ActiveRecord::Base

  before_destroy :destroy_nested_resources

  belongs_to :title_image, :class_name => 'Image'
  belongs_to :catalog_type
  has_many :entry_attributes

  validates :title, :presence => true
  validates :title, :uniqueness => true

  # call to gems included in refinery.
  #has_friendly_id :title, :use_slug => true
  acts_as_nested_set
  default_scope :order => 'lft ASC'
  acts_as_indexed :fields => [:title, :image_titles, :image_names]

  has_many :images_catalog_entries
  has_many :images, :through => :images_catalog_entries, :order => 'images_catalog_entries.position ASC'
  accepts_nested_attributes_for :images, :allow_destroy => false

  def images_attributes=(data)
    self.images.clear

    self.images = (0..(data.length-1)).collect { |i|
      unless (image_id = data[i.to_s]['id'].to_i) == 0
        Image.find(image_id) rescue nil
      end
    }.compact
  end

  def image_titles
    self.images.collect{|i| i.title}
  end

  def image_names
    self.images.collect{|i| i.image_name}
  end

  def image_sole
    if self.images.empty?
      return nil
    else
      return self.images.first
    end
  end

  def show_on_homepage?
    return (self.attribute_value_by_name("show_on_homepage") == true)
  end

  def self.find_visible_on_homepage
    return self.all do |x| x.show_on_homepage? == true end
  end

  alias_attribute :content, :body

  def color
    self.attribute_value_by_name "color"
  end

  def manufacturer
    self.attribute_value_by_name "manufacturer"
  end

  def composition
    self.attribute_value_by_name "composition"
  end

  def article
    self.attribute_value_by_name "article"
  end

  def price
    self.attribute_value_by_name "price"
  end

  def attribute_value_by_name(name)
    a = self.entry_attributes.find_all do |x| x.entry_attribute_type.name == name end

    if a.first.nil?
      return nil
    else
      return a.first.entry_attribute_type_value.value
    end
  end

  private

  def destroy_nested_resources
    entry_attributes.each do |entry|
      entry.destroy
    end
  end




end
