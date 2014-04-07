Rails.application.routes.draw do
  # Root of your site routed with "root ..."
  root 'pages#about'

  resources :tips
  #--------------------------------------------------------------------------
  # These individual routes:
  get '/about'  => 'pages#about',  as: :about_page
  get '/policy' => 'pages#policy', as: :policy_page

  # -> are replaced by the following action setup for the PagesController
  # place all static pages in the ../app/views/pages directory
  # This app has static pages "about.html.erb" and "policy.html.erb" there
  #PagesController.action_methods.each do |action|
  #  get "#{action}", to: "pages##{action}", as: "#{action}_page"
  #end
  #--------------------------------------------------------------------------
end

