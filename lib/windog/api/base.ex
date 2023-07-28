defmodule Windog.Api.Base do
  use HTTPoison.Base

  @endpoint "https://api.winticket.jp"

  def process_url(url) do
    @endpoint <> url
  end

  def process_request_options(opts) do
    opts ++
      [
        timeout: 15_000,
        recv_timeout: 15_000
      ]
  end

  def process_request_headers(headers) do
    token = Application.get_env(:windog, :token)

    headers ++
      [
        {
          "content-type",
          "application/json"
        },
        {
          "cookie",
          "token=#{token}"
        },
        {
          "referer",
          "https://www.winticket.jp/"
        },
        {
          "origin",
          "https://www.winticket.jp/"
        },
        {
          "user-agent",
          "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
        }
      ]
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end
end
