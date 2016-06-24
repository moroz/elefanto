class ImagesController < ApplicationController
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
  before_action :only_authorized, only: [:new, :edit, :create, :update]

  def new
    @image = Image.new
    if params[:title].present?
      @image.title = params[:title]
    end
  end

  def create
    @image = Image.new(image_params);
    if @image.save
      redirect_to @image
    else
      render 'new'
    end
  end

  def show
    image
  end

  def edit
    image
    render 'new'
  end

  def update
    if image.update(image_params)
      flash[:success] = "The image has been successfully updated."
    else
      flash[:danger] = "The image could not be modified."
    end
    redirect_to image
  end

  def index
    @images = Image.all
  end

  def destroy
    @image = Image.find(params[:id])
    if @image.delete
      flash[:success] = "The image has been successfully removed."
      redirect_to images_path
    else
      flash[:danger] = "The image could not be removed."
      redirect_to @image
    end
  end

  private

  def image_params
    params.require(:image).permit(:url, :title, :description)
  end

  def image
    @image ||= Image.find(params[:id])
  end

  def set_s3_direct_post
    logger.debug S3_BUCKET.inspect
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end
end
