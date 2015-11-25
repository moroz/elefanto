class VisitsController < ApplicationController
  include LoggedIn

  def index
    if only_authorized
      @visits = Visit.all.order(:id => :desc).paginate(:page => params[:page])
    end
  end

  def show
    if only_authorized
      @visits = Visit.where(:post_id => params[:post_id]).order(:id => :desc)
    end
  end
end
