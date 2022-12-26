class Admin::UsersController < ApplicationController
  before_action :require_authentication

  def index
    @pagy, @users = page User.order(created_at: :desc)
  end
end

