#https://developers.google.com/identity/protocols/OAuth2#serviceaccount
#https://developers.google.com/identity/protocols/OAuth2ServiceAccount

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
