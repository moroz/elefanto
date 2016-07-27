class VisitsController < ApplicationController
  before_action :only_authorized

  def index
    @visits = Visit.includes(:posts).all.order(:id => :desc).paginate(:page => params[:page])
  end

  def show
    @visits = Visit.where(:post_id => params[:post_id]).order(:id => :desc)
  end
end
