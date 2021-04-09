use Mix.Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :idea_portal, Web.Endpoint,
  http: [:inet6, port: System.get_env("PORT") || 4000],
  url: [host: System.get_env("HOST"), scheme: "https", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :idea_portal, IdeaPortal.Repo,
  ssl: true,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "15")

# Do not print debug messages in production
config :logger, level: :info

# ## Using releases (distillery)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :idea_portal, Web.Endpoint, server: true
#
# Note you can't rely on `System.get_env/1` when using releases.
# See the releases documentation accordingly.

config :idea_portal, :recaptcha,
  module: IdeaPortal.Recaptcha.Implementation,
  secret_key: {:system, "RECAPTCHA_SECRET_KEY"},
  key: {:system, "RECAPTCHA_SITE_KEY"}

config :idea_portal, IdeaPortal.Mailer,
  from: {:system, "MAILER_FROM_ADDRESS"},
  adapter: Bamboo.MailgunAdapter,
  api_key: {:system, "MAILGUN_API_KEY"},
  domain: {:system, "MAILGUN_DOMAIN"}

config :stein, :storage,
  backend: :s3,
  bucket: {:system, "BUCKETEER_BUCKET_NAME"}

config :ex_aws,
  access_key_id: {:system, "BUCKETEER_AWS_ACCESS_KEY_ID"},
  secret_access_key: {:system, "BUCKETEER_AWS_SECRET_ACCESS_KEY"}

if File.exists?("config/prod.secret.exs") do
  import_config "prod.secret.exs"
end
