require File.expand_path("../../lib/catalog.rb", __FILE__)

Refinery::Application.routes.draw do
  match '/catalog', :as => 'catalog', :to => 'catalog#index'

  match '/catalog/filters', :as => 'catalog', :to => 'catalog#filters', :via => "GET"
  match '/catalog/filters', :as => 'catalog', :to => 'catalog#search', :via => "POST"


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
    resources :catalog, :as => :catalog_types do
      resources :types, :as => :entry_attribute_types do
        resources :values, :as => :entry_attribute_type_values
      end
      resources :entries, :as => :catalog_entries do
        resources :attributes, :as => :entry_attributes
        collection do
          post :update_positions
        end
      end
      collection do
        get :empty_values
      end
    end
  end

end

