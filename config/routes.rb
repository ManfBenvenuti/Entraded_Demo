Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root 'pages#home'

  resources :listings do
    # Insert the order ID in the listing URL and restrict actions
    resources :orders, only: [:new, :create]
    resources :listing_steps

  end

  

  # Tipi di chiamate che posso fare con lo standard HTTP: Get, Post, Update, Patch, Delete. Get = visualizza il dato, Post = crea il dato,
  # Update/Patch = Modifica il dato, Delete = cancella il dato. Il tipo di chiamata HTTP la specifichi nel link_to non nel URL
  # Resurces come comportamento di default (convenzione) associa i metodi del controller alle chiamate (es per metodo degli ordini --> :orders
  # /orders(get) --> metodo index
  # /orders(post) --> metodo create
  # /orders(update) --> metodo update
  # /orders(delete) --> metodo delete )

  resources :orders, except: [:new, :create] do
    # Member riguarda uno specifico oggetto
    member do
      post 'accept'
      post 'refuse'
      post 'conclude'
    end
    # Collection mi serve a determinare quale lista di dati mostrare per il generico URL (quando non è specificato un ID specifico nello URL)
    collection do
      get 'sales'
      get 'purchases'
    end
  end
  # Per un motivo ben preciso devi scrivere i percorsi con questa convenzione
  # perché funzioni il nomepagina_path shortcut nei link scritti in ruby
  get 'about' => "pages#about"
  get 'contact' => "pages#contact"
  get 'seller' => "listings#seller"
  get 'listings' => "listings#index"
  get 'show_listings' => "pages#show_listings"




end
