require 'open-uri'
class ImagesController < ApplicationController
  before_action :allow_cross_domain_requests, only: [:index, :search, :autocomplete]
  before_action :set_image, only: [:show, :edit, :update, :destroy, :publish, :klass]
  before_action :check_permissions, only: [:add, :edit, :update, :destroy, :publish]

  def index
    per_page = params[:per].to_i > 0 ? params[:per] : 20
    @images = build_images_relation.includes(:image_ratings).page(params[:page]).per(per_page)
  end

  def random
    image_url = Image.published.order("RANDOM()").first.link

    response.headers['Cache-Control'] = "public, max-age=#{3.hours.to_i}"
    response.headers['Content-Type'] = 'image/jpeg'
    response.headers['Content-Disposition'] = 'inline'
    render :text => open(image_url, "rb").read
  end

  def unknown
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
    @image.update_attributes(published: true, created_at: Time.now)

    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Картиночка одобрена))000' }
      format.js
    end
  end

  def klass
    @image.klass(request.remote_ip)

    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Класс!' }
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

    def allow_cross_domain_requests
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

    def image_params
      params.require(:image).permit(:link, :text)
    end

    def images_for_output
      @random = Image.published.order("RANDOM()").limit(2).load
      params[:image].try(:[],:text) ? Image.where("text ILIKE ?", "%#{params[:image][:text]}%").limit(5).all : [@random.first]
    end

    def build_images_relation
      images = admin? ? Image : Image.published
      images = params[:order] == "rating" ? images.order(rating: :desc) : images.order(id: :desc)
      images = Image.unpublished.order(id: :asc)  if admin? && params[:published]
      images
    end
end
