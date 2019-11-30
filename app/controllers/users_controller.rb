class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @profiles= Profile.all
    @users = User.all
    User.find_each do |user|
      @users = User.all.where("mentor", "%#{params[:users]} %",true)
  end
  @search=User.search(params[:q])
  if params[:q]
  @users=@search.result
  end
end
  def show
    @profiles= Profile.all
  end
  def new
    @user = User.new
  end
  def edit
  end
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id]= @user.id
        format.html { redirect_to @user, notice: 'User was complteted created.' }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
