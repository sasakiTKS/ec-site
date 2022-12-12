Rails.application.routes.draw do
# 管理者用# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
    get '/' => 'homes#top'
    resources :items,only: [:index,:create,:edit,:update,:show,:new]
    resources :genres,only: [:index,:create,:edit,:update]
    resources :customers,only: [:index,:show,:edit,:update]
    resources :orders,only: [:index,:show,:edit,:update]
 end
# 顧客用# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  namespace :public do
   root to: 'homes#top'
   get "about" => "homes#about", as: "about"
   resources :customers,only: [:show,:edit,:update,]
   get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
   patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
   resources :addresses,only: [:index,:create,:edit,:update,:destroy]
   resources :items,only: [:index,:create,:update,:show,]
   resources :cart_items,only: [:index,:update,:destroy,:create] do
        delete 'destroy_all', to: 'cart_items#destroy_all'
   end
   resources :orders do
        collection do
        post 'confirm'
        get 'complete'
   end
   end
 end
end
  # devise_for :admins
  # devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

