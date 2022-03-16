class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # user profile action 
  def profile
    @profile = User.find(params[:id])
  end

  def profile_update
      @profile_update = User.find_by(id:params[:user][:id]) 
      
      if @profile_update.password == params[:user][:password_match]
        if @profile_update.update(email:params[:user][:email])
          respond_to do |format|
            format.js 
          end
        end
      end

      if params[:user][:subscription_email_update].present?
        if @profile_update.update(subscription_email:params[:user][:subscription_email_update])
          @profile_update.update(subscription_email:params[:user][:subscription_email_update])
         
          respond_to do |format|
            format.js 
          end
        end
      else
        @profile_update.errors.add(:email, "wasn't filled in")
        end
  end

  def password
      @password = User.find(params[:id])
  end

  def changes_password
    @password_find = User.find_by(id:params[:user][:id])
    if @password_find.password == params[:user][:old_password]
      if @password_find.update(password:params[:user][:new_password])
        respond_to do |format|
          format.js 
        end
      end
    else
      respond_to do |format|
        format.js 
      end
      @password_find.errors.add(:password, " Wrong password .")
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :subcription, :subscription_email)
    end
end
