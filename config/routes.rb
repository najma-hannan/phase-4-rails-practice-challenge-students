Rails.application.routes.draw do
  resources :students, only: %i[index show create destroy]
  resources :instructors, only: %i[index show update destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
