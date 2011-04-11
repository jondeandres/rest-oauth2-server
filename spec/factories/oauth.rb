require File.expand_path(File.dirname(__FILE__) + '/../support/settings_helper')
include SettingsHelper

FactoryGirl.define do

  factory :user do
     email "alice@example.com"
     password "example"
     uri USER_URI
  end

  factory :oauth_access do
    client_uri CLIENT_URI
    resource_owner_uri USER_URI
  end

  factory :oauth_authorization do
    client_uri CLIENT_URI
    resource_owner_uri USER_URI
    scope ALL_SCOPE
  end

  factory :oauth_token do
    client_uri CLIENT_URI
    resource_owner_uri USER_URI
    scope ALL_SCOPE
  end

  factory :oauth_client do
    uri CLIENT_URI
    name "the client"
    created_from USER_URI
    redirect_uri REDIRECT_URI
    scope ALL_SCOPE
  end

  factory :oauth_client_read, parent: :oauth_client do
    uri ANOTHER_CLIENT_URI
    scope READ_SCOPE
  end




  # TODO: make a factory file just for scopes
  factory :scope do
    uri SCOPE_URI
    name "write"
  end

  factory :scope_pizzas_read, parent: :scope do
    name "pizzas/read"
    values ["pizzas/index", "pizzas/show"]
  end

  factory :scope_pizzas_all, parent: :scope do
    name "pizzas"
    values ["pizzas/create", "pizzas/update", "pizzas/destroy", "pizzas/read"]
  end

  factory :scope_pastas_read, parent: :scope do
    name "pastas/read"
    values ["pastas/index", "pastas/show"]
  end

  factory :scope_pastas_all, parent: :scope do
    name "pastas"
    values ["pastas/create", "pastas/update", "pastas/destroy", "pastas/read"]
  end

  factory :scope_read, parent: :scope do
    name "read"
    values ["pizzas/read", "pastas/read"]
  end

  factory :scope_all, parent: :scope do
    name "all"
    values ["pizzas", "pastas"]
  end

end


