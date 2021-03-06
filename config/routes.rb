CampaignManager::Application.routes.draw do
  get 'welcome/index'
  get 'pending_invitations', to: "campaign_invitations#pending",  as: :pending_invitations
  post 'pending_invitations_accept', to: "campaign_invitations#accept",  as: :accept_invitation
  post 'pending_invitations_decline', to: "campaign_invitations#decline",  as: :decline_invitation
  patch 'update_subscription', to: "campaign_memberships#update",  as: :update_subscription
  get 'campaign_notes/:id/edit', to: "campaign_notes#edit", as: :edit_campaign_note
  delete 'campaign_notes/:id', to: "campaign_notes#destroy", as: :destroy_campaign_note
  
  scope module: :api, path: 'api', as: 'api' do
    scope module: :v1, path: 'v1', as: 'v1' do
      resources :campaigns
    end
  end

  authenticated :user do
    match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
    mount DelayedJobWeb, at: "/delayed_job"
  end

  devise_for :users
  resources :campaigns do
    resources :campaign_notes
  end
  resources :xml_files do get 'download', :user end
  resources :pathfinder_decks do get 'download', :user end
  resources :charges
  resources :characters do get 'download', :user end
  resources :campaign_invitations
  resources :character_campaign_memberships
  post "xml_files" => "xml_files#create_deck"
  root "welcome#index"
 end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
