module GoogleApisService
  module Auth
    class << self
      def authorize(scope)
        authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
          scope: scope
        )
        authorizer.fetch_access_token!
        authorizer
      end

      def authorize_me(scope)
        authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: File.open('/Users/alex/Downloads/credentials-2.json'),
          scope: scope)

        authorizer.fetch_access_token!
      end
    end
  end
end
