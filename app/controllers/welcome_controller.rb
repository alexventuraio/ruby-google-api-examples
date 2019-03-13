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

  def server_side
    auth = "Bearer 'f1VnwC2MKDRkTaWtSvWSZcAKy4C8I6oUhAQpdqrLIz_4YbiYYwyVmyDtg3MwiA'"
    #url = URI.parse('https://docs.google.com/spreadsheets/d/e/2PACX-1vTWCKT5lY4Vp8K6lsT4l5UurXaDb6kV6SkaSW9OBMN58N1GTVgaagnI9OVOH6vGjOh01eZcpgmY4fH4/pubhtml')
    #url = URI.parse('https://docs.google.com/spreadsheets/d/e/2PACX-1vT3V_RewL5fHc3pMOJIN8Xx1BOV9Bh1XHUAhvz9jhFgiLK0KDxhRRpF3dHIygPJqBB_qYJlcW9o8HDc/pubhtml')
    #url = URI.parse('https://docs.google.com/spreadsheets/d/e/2PACX-1vQ9YtDaxRjZR3KTjcCBRy-6jttoKItk-KG1HLQVQssTYgeu1Tv0rWopbOSIBOSmwLQ4RenIRKyrRU4V/pubhtml')
    #url = URI.parse('https://docs.google.com/spreadsheets/d/e/2PACX-1vRmPTFlxE4_7GqQQ2unAd6bX4HttQ_nlMtVWDWceKcAQLLLc0efJQ8xN__ndRpYdfbYgsSTMkXTAVuS/pubhtml')
    url = URI.parse('https://docs.google.com/spreadsheets/d/e/2PACX-1vRp73rjeZ5QKgi10XWcUawaeyjF-WdTUkM6su7goX1RzvmLq106g5onNzL-0nJt0jI7WtlanjMz2omL/pubhtml')

    my_request = Net::HTTP::Get.new(url.to_s, {})

    my_response = Net::HTTP.start(url.host, url.port, :use_ssl => true) do |http|
      http.request(my_request)
    end
    #end.response.body
    my_response.body
    @final_data = setup_assets_links(my_response.body)

    render layout: false
  end

  def demo_link
    google_service = GoogleSheets.new
    @response = google_service.query_sheet
  end

  private

  def setup_assets_links(data)
    index_of = data.index('/static/spreadsheets2/7f4099974e/ritz_tviz_charts/ritz_tviz_charts.nocache.js')
    data.insert(index_of, 'https://docs.google.com') if index_of
    index_of = data.index('/static/spreadsheets2/client/js/1173319635-tviz_client.js')
    data.insert(index_of, 'https://docs.google.com') if index_of
    index_of = data.index('/static/spreadsheets2/client/css/1044422278-waffle_k_ltr.css')
    data.insert(index_of, 'https://docs.google.com') if index_of
    data
  end
end
