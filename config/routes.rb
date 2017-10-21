Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pdf_to_csv#index'
  post 'pdf_to_csv/extract_data', :to=>'pdf_to_csv#extract_data'

end
