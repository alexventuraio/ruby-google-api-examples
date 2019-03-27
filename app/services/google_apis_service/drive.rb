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
      file_name = get_file_name(file_id)

      content = service.export_file(
        file_id,
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        download_dest: "tmp/#{file_name}.xlsx"
      )

      file_name
    end

    def list_files
      # https://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/DriveV3/DriveService#list_files-instance_method
      # List the 10 most recently modified files.
      final_list = []
      response = service.list_files(page_size: 10,
                                    fields: 'nextPageToken, files(id, name, thumbnailLink, webViewLink)')
      puts 'Files:'
      puts 'No files found' if response.files.empty?

      response.files.each do |file|
        puts "#{file.name} (#{file.id}) [#{file.thumbnail_link}] [#{file.web_view_link}]"
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

    def get_file_name(file_id)
      begin
        service.get_file(file_id, fields: 'name').try(:name)
      rescue Google::Apis::ClientError
        raise "Could not find file on drive with ID: #{file_id}"
      rescue => e
        raise "Error: #{e.to_s}"
      end
    end

    def get_slide_thumbnail_url(presentation_id, thumbnail_size='LARGE')
      begin
        @thumbnail_url ||= service.get_presentation_page_thumbnail(
          presentation_id,
          thumbnail_properties_thumbnail_size: thumbnail_size
        ).content_url
      rescue StandardError => e
        raise e.to_s
      end
    end
  end
end
