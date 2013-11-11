GenderGuess::Application.routes.draw do
  # This site will be served entirely from this route
  scope '/gender-guess' do
    # Root
    root 'guess#form', as: :form

    # For guessing
    get 'guess/:height/:weight' => 'guess#guess', as: :guess
    post 'guess_parse' => 'guess#guess_parse', as: :guess_parse

    # For saving the result in DB
    post 'guess/correct' => 'guess#correct', as: :correct
    post 'guess/incorrect' => 'guess#incorrect', as: :incorrect

    # Display results
    get 'results' => 'guess#results'
  end

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :people

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
end
