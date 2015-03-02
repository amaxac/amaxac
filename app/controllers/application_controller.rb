class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :admin?

  def admin
    if params[:key] == ENV["admin_key"]
      session[:key] = ENV["admin_key"]
      flash[:notice] = "хахахахах такс такс такс што тут у нас админы админы админы хахахах наканецта"
    end
    redirect_to search_images_path
  end

  private

  def admin?
    # session[:key] == ENV["admin_key"]
  end
end
