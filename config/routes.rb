RailsApp::Application.routes.draw do

  resources :instances
  resources :projects
  resources :labs
  resources :templates
  match 'admin' => 'admin#index'
  match 'projects/:id/check_out' => 'projects#check_out'
  match 'projects/:id/uncheck_out' => 'projects#uncheck_out'
  match 'projects/:id/deploy' => 'projects#deploy_all'
  match 'projects/:id/deploy_one' => 'projects#deploy_one'
  match 'projects/:id/undeploy' => 'projects#undeploy_all'
  match 'projects/:id/redeploy' => 'projects#redeploy_all'
  match 'projects/:id/destroy_on_backend' => 'projects#destroy_on_backend'
  match 'projects/:id/check_deployed' => 'projects#check_deployed'
  match 'projects/:id/dns_conf_file' => 'projects#dns_conf_file', :defaults => { :format => 'text' }
  match 'instances/:id/undeploy' => 'instances#undeploy'
  match 'instances/:id/callback_script' => 'instances#callback_script'
  match 'instances/:id/check_deployed' => 'instances#check_deployed'
  match 'instances/:id/reachable' => 'instances#reachable'
  match 'instances/:id/install_log' => 'instances#install_log'
  match 'instances/:id/console' => 'instances#console'
  match 'deployments/:id/instance_message' => 'deployments#instance_message'
  match 'deployments/:id/stop' => 'deployments#stop'
  match 'deployments/:id/status' => 'deployments#status'
  match 'deployments/:id/log_messages' => 'deployments#log_messages'
  match 'templates/:id/apply' => 'templates#apply'
  match 'users/:id/make_admin' => 'users#make_admin'
  match 'users/:id/remove_admin' => 'users#remove_admin'
  match 'help' => 'welcome#help'
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
  root :to => 'projects#index'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
