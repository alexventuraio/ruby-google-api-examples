require 'google/apis/drive_v3'

module GoogleApisService
  class Drive
    SCOPE = Google::Apis::DriveV3::AUTH_DRIVE
    #SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY

    attr_accessor :service

    def initialize
      @service = Google::Apis::DriveV3::DriveService.new
      service.authorization = GoogleApisService::Auth.authorize(SCOPE)
    end

    def download_file(file_id)
      content = service.export_file(
        file_id,
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        download_dest: "tmp/#{file_id}.xlsx"
      )
    end

    def list_files
      # List the 10 most recently modified files.
      final_list = []
      response = service.list_files(page_size: 10,
                                    fields: 'nextPageToken, files(id, name)')
      puts 'Files:'
      puts 'No files found' if response.files.empty?

      response.files.each do |file|
        puts "#{file.name} (#{file.id})"
        final_list << { name: file.name, id: file.id }
      end

      final_list
    end
  end
end
