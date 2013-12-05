DesignService::Application.routes.draw do
  resources :portfolios do
    resources :portfolio_items
    member do
      get 'edit_form'
    end
  end

  resources :moderations, only: [:show] do
    member do
      post 'accept'
      post 'reject'
    end
  end

  resources :attachments, only: [:create, :destroy, :show, :index] do
    member do
      get 'download'
    end
  end

  resources :messages
  resources :reviews
  resources :specialist_groups do
    resources :selected_forms
    resources :messages
    resources :reviews, only: [:index]
    resources :portfolios do
      collection do
        get 'new_form'
      end
    end
  end
  resources :specialists do
    resources :messages
    resources :reviews, only: [:index]
    resources :portfolios do
      collection do
        get 'new_form'
      end
    end
  end
  resources :photo_collections
  resources :photos
  resources :portfolio_items

  resources :orders do
    member do
      get 'get_price'
      get 'details'
      put 'agree_price'
      put 'accept_work'
    end
    collection do
      get 'profile1'
      get 'profile2'
      get 'profile3'            
    end
    resources :reviews
    resources :messages do
      member do
        get :show_attachments
        get :show_messages
      end
    end
    resources :attachments
  end

  resource :profile do
    get 'orders'
    get 'new_orders'
    put 'set_avatar'
    post 'add_portfolio'
    get :give_money
  end

  get 'personal_account' => 'personal_accounts#history'
  resource :personal_account   do
    get 'history'
    get 'replenishment'
    get 'contracts'
    get 'acts'
  end

  get 'design_projects/:type' => 'selected_forms#new', as: 'design_project_type'
  get 'design_projects' => 'order_customizers#index'

  resources :selected_forms do
    resources :floor_plans
    resources :attachments
  end

  root :to => 'welcome#index'
  ActiveAdmin.routes(self)

  get 'replanning_endorsements' => 'replanning_endorsements#new'
  resources :replanning_endorsements do
    resources :attachments
  end

  get 'engineering_systems' => 'engineering_systems#new'
  resources :engineering_systems do
    resources :attachments
  end

  get 'plan_developments' => 'plan_developments#new'
  resources :plan_developments do
    member do
     post :start_count
     post :auto_price
     post :to_moderator
    end
    resources :attachments
  end

  # Disable user from destroying his account
  # https://github.com/plataformatec/devise/wiki/How-To:-Disable-user-from-destroying-his-account
  devise_for :users, skip: :registrations, :controllers => {:sessions => 'sessions', :passwords => 'password'}
  devise_scope :user do
    resource :registration,
              only: [:new, :create, :edit, :update],
              path: 'users',
              path_names: { new: 'sign_up' },
              controller: 'registrations',
              as: :user_registration do
                get :stage2
                get :cancel
                post :short
              end
  end

  resources :purchases, :only => [:index] do
   collection do
    get :ok
    get :bad
   end
  end

  namespace :admin do    
    post 'users/:id/group_remove' => 'users#group_remove', :as => :user_group_remove
    post 'users/:id/group_add' => 'users#group_add', :as => :user_group_add
    delete 'specialist_groups/:id/remove_specialist' => 'specialist_groups#remove_specialist', as: :specialist_group_remove_specialist
    get "specialization/:id/specialists" => 'specialization#specialists', as: :specialization_specialists
    get "specialization/:id/specialist_groups" => 'specialization#specialist_groups', as: :specialization_specialist_groups
  end

  get "welcome/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
