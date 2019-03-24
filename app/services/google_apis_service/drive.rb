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
      # https://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/DriveV3/DriveService#export_file-instance_method
      content = service.export_file(
        file_id,
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        download_dest: "tmp/#{file_id}.xlsx"
      )
    end

    def list_files
      # https://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/DriveV3/DriveService#list_files-instance_method
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

    def delete_file(file_id)
      # https://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/DriveV3/DriveService#delete_file-instance_method
      # Going this way:
      # When the request was success 'result' is equals to '' and 'err' is nil
      # When the request had failed then 'err' is equals to object and 'result' is nil
      # You can read the 'err.status_code' and 'err.message' to return
      #service.delete_file(file_id) do |result, err|
        #data = result || err
      #end

      # In this way you only get a '' if the request was sucessfull otherwise we need
      # to handle the exception to have acccess to the 'error' object
      content = service.delete_file(file_id)

    rescue Google::Apis::ClientError => error
      puts "💭 " * 50
      pp(error.message)
    end
  end
end
