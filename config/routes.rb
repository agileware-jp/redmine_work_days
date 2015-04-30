# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :rest_days do
  post :import, :on => :collection
  delete :range_delete, :on => :collection
end
