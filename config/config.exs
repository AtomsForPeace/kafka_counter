# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kafka_counter,
  ecto_repos: [KafkaCounter.Repo]

# Configures the endpoint
config :kafka_counter, KafkaCounterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ThHmyhaVcM4dOkxQOTqpcJKphy4B7gCuGU6AiMJ1fLM0wmn0ZUI0ifzQa3Ht3UFI",
  render_errors: [view: KafkaCounterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: KafkaCounter.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configuration for kafka_ex
config :kafka_ex, brokers: [{"localhost", 9092}]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
