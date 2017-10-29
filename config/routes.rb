Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  root 'wb_trans_portfolio#index'
  get 'upload_trans_file' ,:to=>'wb_trans_portfolio#upload_trans_file', :as=>'upload_trans_file'
 
  post 'wb_trans_portfolio/upload_trans_portfolio_index'
  post 'wb_trans_portfolio/upload_trans_portfolio'
  post 'wb_trans_portfolio/update_subaccount_index'
  post 'wb_trans_portfolio/create_subaccount_index'
  post 'wb_trans_portfolio/extract_data', :to=>'wb_trans_portfolio#extract_data'




end
