Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.google[:GOOGLE_CLIENT_ID], Rails.application.credentials.google['GOOGLE_CLIENT_SECRET']
  {
    scope: 'email',
    redirect_uri: Rails.application.credentials.google[:GOOGLE_REDIRECT_URI]
  }
end
OmniAuth.config.allowed_request_methods = [:post, :get]