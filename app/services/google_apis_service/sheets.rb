require 'google/apis/sheets_v4'

module GoogleApisService
  class Sheets
    SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS
    #SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY

    attr_accessor :service

    def initialize
      @service = Google::Apis::SheetsV4::SheetsService.new
      service.authorization = GoogleApisService::Auth.authorize(SCOPE)
    end
  end
end

