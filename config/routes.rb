Rails.application.routes.draw do
  get 'character/:id', to: 'rickmorty_api#character_by_id'
  get 'episode', to: 'rickmorty_api#episode_by_name'
end
