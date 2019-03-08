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
    end
  end
end
