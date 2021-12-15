import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :users, UsersWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "6lRBhz0wJaTNOeFoJApVY18X+C7JuAR1ABZ9bIJBPkwLTTgUG4J+WCG3rgH6ofnJ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
