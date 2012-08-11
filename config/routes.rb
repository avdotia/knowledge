Knowledge::Application.routes.draw do
############## comente el get articles new y puse el resources articles
#  get "articles/new"
resources :articles
#get "articles/show"

#match '/edit',  to: 'articles#edit'


end
