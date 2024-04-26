Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'country_informations/search_country', to: 'country_informations#search_country'
    end
  end
end
