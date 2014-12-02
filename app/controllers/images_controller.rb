require 'open-uri'
class ImagesController < ApplicationController
  before_action :set_image, only: [:edit, :update, :destroy, :publish]
  before_action :check_permissions, only: [:add, :edit, :update, :destroy, :publish]

  def index
    @images = admin? ? Image : Image.published
    @images = Image.unpublished  if admin? && params[:published]
    @images = @images.order(id: :desc).page(params[:page]).per(20)
  end

  def random
    image = Dragonfly.app.fetch_url(Image.published.order("RANDOM()").first.link)
    image_url = Image.published.order("RANDOM()").first.link

    # response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
    response.headers['Content-Type'] = 'image/jpeg'
    response.headers['Content-Disposition'] = 'inline'
    render :text => open(image_url, "rb").read
  end

  def show
  end

  def search
    @images = images_for_output
  end

  def autocomplete
    respond_to do |format|
      format.html
      format.json { render json: Image.for_autocomplete(params[:term]) }
    end
  end

  def new
    @image = Image.new
  end

  def add
    if request.post?
      @result = Image.add_images(params[:image][:text], request.remote_ip)
      flash[:notice] = "Добавлено #{@result[:i]} картинок"
    end
  end

  def edit
  end

  def create
    @image = Image.new(image_params)
    @image.published = admin?
    @image.added_by = request.remote_ip

    respond_to do |format|
      if @image.save
        @message = admin? ? "Картиночка добавлена))0" : 'Принято на рассмотрение))000'
        format.html { redirect_to @image, notice: @message }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Картиночка изменена))00' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Картиночка удалена))000' }
      format.js
    end
  end

  def publish
    @image.update_attribute(:published, true)

    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Картиночка одобрена))000' }
      format.js
    end
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def check_permissions
      unless admin?
        flash[:alert] = "ОЗАЙБЫРГЕН ПИЗДА"
        redirect_to :back
      end
    end

    def image_params
      params.require(:image).permit(:link, :text)
    end

    def images_for_output
      @random = Image.published.order("RANDOM()").limit(2).load
      params[:image].try(:[],:text) ? Image.where("text ILIKE ?", "%#{params[:image][:text]}%").limit(5).all : [@random.first]
    end
end
