Rails.application.routes.draw do
  root 'home#index'

  mount ActionCable.server => '/cable'

  resources :newsfeeds
  resources :search
  resources :music_choices do
    resources :comments
    resources :suggestions
    resources :likes
    resources :stashed_musics
  end

  resources :stashed_musics

  resources :comments, only: [] do
    resources :likes
  end

  resources :suggestions, only: [] do
    resources :likes
  end

  devise_for :users, :controllers => { :omniauth_callbacks => 'callbacks' }


  resources :users
  resources :likes
  resources :home
  resources :followings

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/notifications" => "mailbox#notifications", as: :mailbox_notifications
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash
  get "mailbox/empty_trash" => "mailbox#empty_trash", as: :empty_trash
  get "mailbox/notification_read" => "mailbox#notification_read",
      as: :notification_read
  get "mailbox/notification_all_read" => "mailbox#notification_all_read",
      as: :notification_all_read

end
