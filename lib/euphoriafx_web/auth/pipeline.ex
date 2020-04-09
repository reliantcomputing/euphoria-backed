defmodule EuphoriafxWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :euphoriafx,
    module: EuphoriafxWeb.Auth.Guardian,
    error_handler: EuphoriafxWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
