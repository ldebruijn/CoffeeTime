defmodule CoffeeTime do
  @moduledoc """
  Documentation for `CoffeeTime`.
  """
  use Application

  @doc """
  Hello world.

  ## Examples

      iex> CoffeeTime.hello()
      :world

  """
  def send_notification() do
    gif = get_random_giphy()
    send_gchat_notification(gif)

  end

  def build_payload(gif) do
    payload = %{
      cards: [%{
        header: %{
          title: "Coffee time!",
          subtitle: "",
          imageUrl: "https://www.gstatic.com/images/icons/material/system/2x/free_breakfast_googblue_48dp.png",
          imageStyle: "IMAGE"
        },
        sections: [%{
          widgets: [%{
              textParagraph: %{
                text: "<b>Goooood morning everyone!</b> Another beautiful day awaits! \n\nGrab a coffee and come start your day by saying hi in the following channel"
              }
            },
            %{
              image: %{
                imageUrl: gif,
                onClick: %{
                  openLink: %{
                    url: gif
                  }
                }
              }
            },
            %{
              buttons: [%{
                textButton: %{
                  text: "Join the chat and say hello!",
                  onClick: %{
                    openLink: %{
                      url: Application.fetch_env!(:coffeetime, :chat_room)
                    }
                  }
                }
              }]
            }
          ]
        }]
      }]
    }

    payload
  end

  def send_gchat_notification(gif) do
    payload = build_payload(gif)

    params = %{
      key: Application.fetch_env!(:coffeetime, :gchat_webhook_key),
      token: Application.fetch_env!(:coffeetime, :gchat_webhook_token)
    }

    IO.inspect params

    headers = [{"Content-Type", "application/json"}]

    IO.inspect headers

    room_key = Application.fetch_env!(:coffeetime, :gchat_webhook_room_key)
    {code, response } = case HTTPoison.post "https://chat.googleapis.com/v1/spaces/#{room_key}/messages", Poison.encode!(payload), headers, params: params do
      {:ok, %HTTPoison.Response{body: raw, status_code: code}} ->
        {code, raw |> Poison.decode!() }
      {:error, %{reason: reason}} -> {:error, reason, []}
    end

    IO.puts "Statuscode: #{code}"

    response
  end

  def get_random_giphy() do
    random = :rand.uniform(2)
    IO.puts "Random value: #{random}"

    query = case random do
      1 -> "good morning"
      2 -> "coffee"
      _ -> "happy coffee"
    end

    IO.puts "Query: #{query}"

    url = "https://api.giphy.com/v1/gifs/search"

    params = %{
      api_key: Application.fetch_env!(:coffeetime, :giphy_api_key),
      q: query,
      limit: 1,
      offset: :rand.uniform(200),
      rating: "G",
      lang: "en"
    }

    IO.puts "URL: #{url}"
    IO.puts "Options: "
    IO.inspect params

    {_code, response } = case HTTPoison.get(url, [], params: params) do
      {:ok, %HTTPoison.Response{body: raw, status_code: code}} ->
        {code, raw |> Poison.decode!() }
      {:error, %{reason: reason}} -> {:error, reason, []}
     end

     gif = Enum.at(response["data"], 0)["images"]["original"]["url"]
     IO.puts "Embedding URL: #{gif}"

     gif
  end

  def start(_type, _args) do
    IO.puts "Starting application"
    send_notification()
    IO.puts "Trying to read environment variables..."
    IO.puts Application.fetch_env!(:coffeetime, :giphy_api_key)

    IO.puts "Successfully did my job. Shutting down..."
    :init.stop
  end
end
