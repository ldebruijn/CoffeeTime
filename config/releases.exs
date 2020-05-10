import Config

config :coffeetime,
  giphy_api_key: System.fetch_env!("CT_GIPHY_API_KEY"),
  gchat_webhook_room_key: System.fetch_env!("CT_GCHAT_ROOM_KEY"),
  gchat_webhook_key: System.fetch_env!("CT_GCHAT_KEY"),
  gchat_webhook_token: System.fetch_env!("CT_GCHAT_TOKEN"),
  chat_room: System.fetch_env!("CT_CHAT_ROOM")
