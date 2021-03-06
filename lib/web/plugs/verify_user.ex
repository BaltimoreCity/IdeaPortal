defmodule Web.Plugs.VerifyUser do
  @moduledoc """
  Verify a _admin_ user is in the session
  """

  import Plug.Conn
  import Phoenix.Controller

  alias Web.Router.Helpers, as: Routes

  def init(default), do: default

  def call(conn, _opts) do
    case Map.has_key?(conn.assigns, :current_user) do
      true ->
        conn

      false ->
        uri = %URI{path: conn.request_path, query: conn.query_string}

        conn
        |> put_flash(:info, "You must sign in first.")
        |> put_session(:last_path, URI.to_string(uri))
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()
    end
  end
end
