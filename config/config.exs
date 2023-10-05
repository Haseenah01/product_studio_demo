# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :product_studio_demo,
  ecto_repos: [ProductStudioDemo.Repo]

# Configures the endpoint
config :product_studio_demo, ProductStudioDemoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: ProductStudioDemoWeb.ErrorHTML, json: ProductStudioDemoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ProductStudioDemo.PubSub,
  live_view: [
    signing_salt: "2kur8sXG"
    # signing_salt: "KK4ly8HdzOmhsB+2itWau5xYDIPW8ctk"
  ]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :product_studio_demo, ProductStudioDemo.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# config :ex_json_schema,
#   :remote_schema_resolver,
#   fn url -> HTTPoison.get!(url).body |> Poison.decode! end

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
