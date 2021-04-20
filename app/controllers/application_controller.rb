class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |exception|
    errors = [exception.message]
    render json: errors, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    errors = [exception.message]
    render json: errors, status: :unprocessable_entity
  end
end
