require File.expand_path("../../lib/catalog.rb", __FILE__)

Refinery::Application.routes.draw do
  match '/catalog', :as => 'catalog', :to => 'catalog#index'

  # Make sure you restart your web server after changing the multi level setting.
  if ::Refinery::Catalog.multi_level?
    match "/catalog/:id/projects/:catalog_id/:image_id",
          :as => :catalog_image,
          :to => "catalog#show"

    match "/catalog/:id/projects/:catalog_id",
          :as => :catalog_project,
          :to => "catalog#show"
  else
    match "/catalog/:id/:image_id",
          :as => :catalog_image,
          :to => "catalog#show"

    match "/catalog/:id",
          :as => :catalog_project,
          :to => "catalog#show"
  end

  match '/catalog/:id', :as => 'catalog', :to => 'catalog#show'

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :catalog, :as => :catalog_entries do
      collection do
        post :update_positions
      end
    end
  end

end

