class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(id: params[:user_id])

    if user
      reset_session # セッション固定攻撃への対策
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Login successed'
    else
      redirect_to root_path, alert: 'Login Failed'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Logout successed'
  end
end
