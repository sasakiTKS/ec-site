Rails.application.routes.draw do
# 管理者用# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
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
    get 'homes/top'
    get 'homes/about'
  end
end
  # devise_for :admins
  # devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

