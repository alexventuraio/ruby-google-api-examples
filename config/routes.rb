Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/sheets'
  get 'welcome/server_side'
  get 'welcome/demo_link'
  get 'welcome/drive'
  get 'welcome/download_file'

  root to: 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
