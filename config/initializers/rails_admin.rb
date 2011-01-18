require "rails_admin/application_controller"

module RailsAdmin
  class ApplicationController < ::ApplicationController
    filter_access_to :all
  end
end

RailsAdmin.config do |config|
  config.model User do
    field :first_name
    field :last_name
    field :email
    field :password
    field :password_confirmation
    field :travel_log_service_enabled
    field :travel_log_service_interval
  end
end
