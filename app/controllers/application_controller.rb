class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

protect_from_forgery with: :exception
#Can't verify CSRF token authenticity=CSRFトークン認証のためのコード

  #現在サインインしてるユーザーのindexページに飛ばす

  def after_sign_in_path_for(resource)
   books_path(current_user.id)
  end


  def after_sign_out_path_for(resource)
   root_path
  end

  protected

 #config側で「名前で認証」設定しているため、こちらでemailを許可
 def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
 end
end