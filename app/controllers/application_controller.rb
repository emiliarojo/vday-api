class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    authorization_header = request.headers['Authorization']
    unless authorization_header.present? && valid_token?(authorization_header)
      render json: { error: 'Access Denied' }, status: :unauthorized
    end
  end

  def valid_token?(token)
    User.find_by(token: token).present?
  end
end
