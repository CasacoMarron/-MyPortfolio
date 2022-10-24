class ApplicationController < ActionController::Base
  #ログインしていない状態で、ログイン画面へリダイレクト
  before_action :authenticate_user!,except: [:top, :about]
  #devise利用の機能（ユーザ登録、ログイン認証など）が使われる場合、
  #その前にconfigure_permitted_parametersが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  protected
  #configure_permitted_parametersでは、devise_parameter_sanitizer.permitで、
  #nameのデータ操作を許可するアクションメソッドが指定されている
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])#sign_up時にemailを許可しな
  end
end
