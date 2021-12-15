import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :inventory, InventoryWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "00ffJqLMA2wNpdSPzg2QYtRVU75m0rULRnz3Ysl9XAqwx9jLsdSPEJuo399JFB4G",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
