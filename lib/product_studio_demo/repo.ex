defmodule ProductStudioDemo.Repo do
  use Ecto.Repo,
    otp_app: :product_studio_demo,
    adapter: Ecto.Adapters.Postgres
end
