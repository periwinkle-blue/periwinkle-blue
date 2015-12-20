OmniAuth.config.on_failure = -> (env) do
  Rack::Response.new(['302 Moved'], 302, 'Location' => env['omniauth.origin'] || "/").finish
end

#Other attempts...
# OmniAuth.config.on_failure = OauthCallbackController.action(:oauth_failure)

# OmniAuth.config.on_failure = Proc.new do |env|
#   OauthCallbackController.action(:oauth_failure).call(env)
#   # this will invoke the omniauth_failure action in UsersController.
# end
