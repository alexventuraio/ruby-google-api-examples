class WelcomeController < ApplicationController
  def index
    google_service = GoogleApisService::Sheets.new
    #render json: { google_service: google_service }, status: 200
    #my_access_token = google_service.service.request_options.authorization.access_token

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: google_service }
    end
  end

  def demo_net
    auth = "Bearer 'ya29.c.ElrGBsHLQTYH0QVDliyjx3oWvJcC9ANd0gzp5r3btQq7vUyu1t0B8tHJZU7O_f1VnwC2MKDRkTaWtSvWSZcAKy4C8I6oUhAQpdqrLIz_4YbiYYwyVmyDtg3MwiA'"
    uri = URI.parse('https://docs.google.com/a/genoatelepsychiatry.com/spreadsheets/d/e/2PACX-1vTWCKT5lY4Vp8K6lsT4l5UurXaDb6kV6SkaSW9OBMN58N1GTVgaagnI9OVOH6vGjOh01eZcpgmY4fH4/pubhtml')
    url = URI.parse('https://docs.google.com/spreadsheets/d/1cl25ziRA74FtMHTzGKj7_0QcPu93RNV8mPVnB4A3g8U/edit')
    my_request = Net::HTTP::Get.new(url.to_s, { 'Authorization' => auth })

    @response = Net::HTTP.start(url.host, url.port, :use_ssl => true) do |http|
      http.request(my_request)
    end
    #end.response.body
  end

  def demo_link
    google_service = GoogleSheets.new
    @response = google_service.query_sheet
  end
end
