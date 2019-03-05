class WelcomeController < ApplicationController
  def index
    service = GoogleApisService::Sheets.new
    render json: { service: service }, status: 200
  end
end
