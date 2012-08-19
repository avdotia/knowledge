Knowledge::Application.routes.draw do
############## comente el get articles new y puse el resources articles
#  get "articles/new"
  root to: redirect("/#{I18n.default_locale}/")

  scope ':locale', locale: /#{I18n.available_locales.join('|')}/ do
    #[es, en, fr] => /es|en|fr/
    root to: 'articles#index'

    resources :articles do
      member do
        get 'filter'
      end
    end
    
    match '*dummy', to: 'error#error_404'
  end

#get "articles/show"

#match '/edit',  to: 'articles#edit'

  match '*dummy', to: 'error#error_404', locale: I18n.default_locale.to_s

end
