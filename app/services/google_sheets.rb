require 'google/apis/sheets_v4'
require 'googleauth'

class GoogleSheets
  attr_accessor :service

  def initialize
    # Connect to Google
    @service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = 'Some application name'
    service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
    )
  end

  def query_sheet
    # Query the spreadsheet
    spreadsheet_id = "1cl25ziRA74FtMHTzGKj7_0QcPu93RNV8mPVnB4A3g8U"
    range = 'Sheet1!A1:H23'

    response = service.get_spreadsheet_values(spreadsheet_id, range)

    # Use the first row as a header row, then turn each subsequent row into a hash using the header row values as keys
    header = response.values.first.map(&:to_s)
    response.values
      .drop(1)
      .map{ |row| Hash[header.zip(row)] }
  end
end
