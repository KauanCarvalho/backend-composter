# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api do
    namespace :instrument do
      resource :measurements, only: [] do
        member do
          get 'list_all_records_with_pagination'
          post 'create_in_batch'
        end
      end
    end
  end
end
