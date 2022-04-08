class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  #現在サインインしてるユーザーのshowページに飛ばす

  def after_sign_in_path_for(resource)
   user_path(current_user.id)
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
