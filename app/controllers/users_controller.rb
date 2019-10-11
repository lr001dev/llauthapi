class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.select('first_name, last_name, email, id').all
    render json: @users
  end

  def check
    if get_current_user.id
      render json: { user: get_current_user.id }
    end
  end

  def destroyCookie
    cookies.delete(:jwt)
  end

  def show
    render json: @user
  end

  def login
    user = User.find_by(email: params[:user][:email])
    puts user
    if user && user.authenticate(params[:user][:password])

      token = create_token(user.id, user.email)
      cookies.signed[:jwt] = { value: token, httponly: true }
      render json: {status: 200, token: token, user: user }
    else
      render json: {status: 401, message: "Unauthorized"}
    end
  end

  # POST /users
    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: 201
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.select('first_name, last_name, email, id').find(params[:id])
    end

    def set_user_update
      @user = User.find(params[:id])
    end

    def create_token(id, email)
      JWT.encode(payload(id, email), ENV['JWT_SECRET'], 'HS256')
    end

    def payload(id, email)
      {
        exp: (Time.now + 30.minutes).to_i,
        iat: Time.now.to_i,
        iss: ENV['JWT_ISSUER'],
        user: {
          id: id,
          email: email
        }
      }
  end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
