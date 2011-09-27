module CatalogHelper

  def catalog_image_link(master, catalog, image_index)
    if ::Refinery::Catalog.multi_level?
      catalog_image_url(master, catalog, image_index)
    else
      catalog_image_url(master, image_index)
    end
  end

  def link_to_catalog_image(master, catalog, image, index)
    link_to(image_fu(image, '96x96#c'),
            catalog_image_link(master, catalog, index))
  end

end

