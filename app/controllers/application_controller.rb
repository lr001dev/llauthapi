class ApplicationController < ActionController::API
    include ::ActionController::Cookies
    def authenticate_token
      render json: { status: 401, message: 'Unauthorized' } unless decode_token(cookies.signed[:jwt])
    end

    def bearer_token
      header = cookies.signed[:jwt]
    end

    def decode_token(token_input)
      puts "cookie in decode"
      puts token_input
      JWT.decode(token_input, ENV['JWT_SECRET'], true)
    rescue
      render json: { status: 401, message: 'Unauthorized' }
    end

    def get_current_user
      return if !bearer_token
      decoded_jwt = decode_token(cookies.signed[:jwt])
      User.find(decoded_jwt[0]["user"]["id"])
    end

    def authorize_user
      puts "user id"
      puts get_current_user.id
      puts "Params"
      puts params[:id].to_i

      render json: { status: 401, message: "Unauthorized" } unless get_current_user.id == params[:id].to_i
    end

  end
