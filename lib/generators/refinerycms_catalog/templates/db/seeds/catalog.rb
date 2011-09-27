User.find(:all).each do |user|
  user.plugins.create({
    :name => "catalog",
    :position => (user.plugins.maximum(:position) || -1) +1
  }) unless user.plugins.find_by_name('catalog').present?
end

unless Page.find_by_link_url('/catalog').present?
  page = Page.create({
    :title => "Catalog",
    :link_url => "/catalog",
    :menu_match => "\/catalog(|\/.+?)",
    :deletable => false,
    :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1)
  })
  Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end

