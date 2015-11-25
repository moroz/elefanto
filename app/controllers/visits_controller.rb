class VisitsController < ApplicationController
  def index
    @visits = Visit.all.order(:id => :desc).paginate(:page => params[:page])
  end

  def show
    @visits = Visit.where(:post_id => params[:post_id])
    render 'index'
  end
end
