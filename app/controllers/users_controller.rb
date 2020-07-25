class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_correct_user(params[:id]), {only: [:edit, :update, :destroy]}

  def show
  	@user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def create
      @book.user_id = current_user.id
      @book = Book.new(book_params)
   if @book.save
   flash[:success] = "You have creatad user successfully."
      redirect_to @book
    else
   flash[:danger] = @book.errors.full_messages
      @books = Book.all
      render 'index'
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user)
    end
  end

  def update
    if current_user
       @user = User.find(params[:id])
       if @user.update(user_params)
       	flash[:success] = "You have updated user successfully."
          redirect_to user_path(@user.id)
         else
          flash[:danger] = @user.errors.full_messages
          render "edit"
       end
     else
    end
   end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

