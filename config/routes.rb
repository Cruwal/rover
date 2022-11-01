Rails.application.routes.draw do
  root to: 'test_rovers#index'

  get 'rover', to: 'test_rovers#index'
  post 'rover', to: 'test_rovers#commands'
end
