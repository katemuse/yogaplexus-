ActionController::Routing::Routes.draw do |map|
  
  #map.resources :sequences, :member => { :get_postures => :get }
  
  map.resources :asanas, :has_many=>:user_observations
  
  map.resources :users, :member => {:home => :get, :suspend => :put, :unsuspend => :put, :purge => :delete } 
  
  map.resources :asana_types
  map.resources :asana_subtypes     

  map.resources :user_observations 

 #map.resources' named routes took a while to figure out, especially using a :has_many :through relationship.
 #I still need to try the following variants:     
        #1. add a custom method  (get_postures) to my sequences_controller that will return all the relevant asanas:

     # def get_postures
     # @sequence = Sequence.find(params[:id])
     # @postures = @sequence.postures.asanas    (if this doesn't work maybe - @sequence.postures.collect {|p| p.asana})  - will.)
     # end   
     # 
     #        Then add this method to my sequences route:
     # 
     #  map.resources :sequences, :member => { :get_postures => :get }
     # 
     #        Then I should be able to call the following to get all postures of a sequence:
     #  
     #  http://yogaplexus.com/users/1/sequence/2/get_postures        
     # using which named route?  Try get_postures_sequence_path(2)
   
        



  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'    
  
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil 


  map.resource :session    
  
  

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
