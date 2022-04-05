Rails.application.routes.draw do
  get 'books/show'
  get 'books/index'
  get 'books/edit'
 root to: 'homes#top'
  get 'homes/about'=>"homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
