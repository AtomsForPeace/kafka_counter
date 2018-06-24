defmodule KafkaCounterWeb.PageController do
  use KafkaCounterWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
