require "rails_admin/application_controller"

module RailsAdmin
  class ApplicationController < ::ApplicationController
    filter_access_to :all
  end
end

RailsAdmin.config do |config|
  config.model User do
    object_label do
      "#{bindings[:object].full_name}"
    end
    field :first_name
    field :last_name
    field :email
    field :password
    field :password_confirmation
    field :travel_log_service_enabled
    field :travel_log_service_interval do
      length 8
    end
    field :participating_in_study
  end
  config.model Landmark do
    edit do
      field :name
      field :user
      field :latitude
      field :longitude
    end
  end
end
