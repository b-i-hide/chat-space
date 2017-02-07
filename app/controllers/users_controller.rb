class UsersController < ApplicationController
  def search
    input = params.require(:user)[:name]
    @users = User.where("name LIKE?", "%#{input}%")
    respond_to do |format|
      format.json { render json: @users }
    end
  end
end
