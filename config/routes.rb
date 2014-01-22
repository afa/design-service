# coding: utf-8
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
    get 'profile1'
    get 'profile2'
    get 'profile3'            
    get 'profile4'
    get 'profile5'
    get 'profile6'    
  end

  get 'personal_account' => 'personal_accounts#history'
  resource :personal_account   do
    get 'history'
    get 'replenishment'
    get 'contracts'
    get 'acts'
    get 'pa_transactions'
    get 'pa_services'
    get 'payment1_stage1'
    get 'payment1_stage2'
    get 'payment2_stage1'
    get 'payment2_stage2'
    get 'payment3_stage1'
    get 'payment3_stage2'
    get 'payment3_stage3'
  end

  get 'design_projects/:type' => 'selected_forms#new', as: 'design_project_type'
  get 'design_projects' => 'order_customizers#index'

  resources :selected_forms do
    resources :floor_plans
    resources :attachments
  end

  resources :welcome do
    get 'anketa1'
    get 'anketa2'
    get 'anketa3'
    get 'anketa4'
    get 'anketa5'
    #get 'anketa1' => 'welcome#anketa1', :as => :welcome_anketa1
    #get 'anketa2' => 'welcome#anketa2', :as => :welcome_anketa2
    #get 'anketa3' => 'welcome#anketa3', :as => :welcome_anketa3
    #get 'anketa4' => 'welcome#anketa4', :as => :welcome_anketa4
    #get 'anketa5' => 'welcome#anketa5', :as => :welcome_anketa5
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

  namespace :adm do
    get '/' => 'index#index', :as => :index_index
    resources :index do
      get 'index'
    end
    resources :orders
    resources :specialists
    post 'specialists/get_by_specialization' => 'specialists#get_by_specialization', :as => :specialists_get_by_specialization
    
    resources :specialist
    post 'specialist/add' => 'specialist#add', :as => :client_add
    post 'specialist/set' => 'specialist#set', :as => :specialist_set
    post 'specialist/del' => 'specialist#del', :as => :specialist_del
    post 'specialist/add_to_group' => 'specialist#add_to_group', :as => :specialist_add_to_group
    post 'specialist/del_from_group' => 'specialist#del_from_group', :as => :specialist_del_from_group
    post 'specialist/set_specialization' => 'specialist#set_specialization', :as => :specialist_set_specialization
    
    resources :order
    post 'order/check_new' => 'order#check_new', :as => :order_check_new
    post 'order/set_specialist' => 'order#set_specialist', :as => :order_set_specialist
    post 'order/send_message' => 'order#send_message', :as => :order_send_message
    resources :specialist_group do
      get 'get_by_specialist'
    end
    resources :specialist do
      get 'get_by_group_and_specialization'
      get 'get_price'
    end
    resources :clients
    resources :client
    post 'client/add' => 'client#add', :as => :client_add
    post 'client/autorization' => 'client#autorization', :as => :client_autorization
    post 'client/set_client' => 'client#set_client', :as => :client_set_client
    post 'client/del' => 'client#del', :as => :client_del
    post 'client/set_password' => 'client#set_password', :as => :client_set_password
    resources :groups
    resources :group
    post 'group/set' => 'group#set', :as => :group_set
    post 'group/add' => 'group#add', :as => :group_add
    get 'group/:id/show_orders' => 'group#show_orders', :as => :group_show_orders
    resources :portfolio_item
    post 'portfolio_item/get_next' => 'portfolio_item#get_next', :as => :portfolio_item_get_next
  end

  get "welcome/index"
  #get "welcome/anketa1"

  

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
