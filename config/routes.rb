Rails.application.routes.draw do
  root 'cycles#index'

  resources :cycles, only: :none do
    resources :invitations, only: %i[new create]
  end
end
