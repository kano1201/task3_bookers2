class UsersController < ApplicationController
     before_action :correct_user,only: [:edit, :update, :destroy]
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
  end

  def edit
   @user = User.find(params[:id])
   if @user.id == current_user.id
     render 'edit'
   else
      redirect_to user_path(@user.id)
   end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  end

  def index
     @users = User.all
     @user = current_user
     @book = Book.new
  end

 private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def correct_user
    user = User.find(params[:id])
    redirect_to user_path(current_user) unless current_user?(user)
  end
  def current_user?(user)
    user == current_user
  end

end