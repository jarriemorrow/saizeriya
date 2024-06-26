class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  def index
  end

  def new
  end

  def show
  end
end
