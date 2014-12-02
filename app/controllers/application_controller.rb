class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :admin?

  def admin
    if params[:key] == ENV["admin_key"]
      session[:admin] = true
      flash[:notice] = "Теперь вы админ!"
    end
    redirect_to search_images_path
  end

  private

  def admin?
    session[:admin] || false
  end
end
