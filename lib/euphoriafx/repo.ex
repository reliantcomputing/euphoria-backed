defmodule Euphoriafx.Repo do
  use Ecto.Repo,
    otp_app: :euphoriafx,
    adapter: Ecto.Adapters.Postgres
end
