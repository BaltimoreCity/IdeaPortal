defmodule Web.AccountView do
  use Web, :view

  alias IdeaPortal.Accounts.Avatar
  alias Stein.Storage
  alias Web.FormView
  alias Web.SharedView

  def avatar_url(user) do
    case is_nil(user.avatar_key) do
      true ->
        Routes.static_path(Web.Endpoint, "/images/icon-profile.png")

      false ->
        Storage.url(Avatar.avatar_path(user, "thumbnail"), signed: [expires_in: 3600])
    end
  end

  def avatar_img(user) do
    img_tag(avatar_url(user), alt: "Avatar")
  end

  def full_name(user) do
    "#{user.first_name} #{user.last_name}"
  end
end
