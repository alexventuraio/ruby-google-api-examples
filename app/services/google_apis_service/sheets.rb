require 'google/apis/sheets_v4'

module GoogleApisService
  class Sheets
    attr_accessor :service

    SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS
    #SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY

    def initialize
      @service = Google::Apis::SheetsV4::SheetsService.new
      service.authorization = GoogleApisService::Auth.authorize(SCOPE)
    end
  end
end
