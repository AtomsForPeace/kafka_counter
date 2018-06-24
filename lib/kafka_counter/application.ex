defmodule KafkaCounter.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    consumer_group_opts = [
      # setting for the ConsumerGroup
      heartbeat_interval: 1_000,
      # this setting will be forwarded to the GenConsumer
      commit_interval: 1_000
    ]

    consumer_impl = KafkaConsumer
    consumer_group_name = "my_group"
    topic_names = ["test"]



    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(KafkaCounter.Repo, []),
      # Start the endpoint when the application starts
      supervisor(KafkaCounterWeb.Endpoint, []),
      # Start the KafkaConsumer
      supervisor(
        KafkaEx.ConsumerGroup,
        [consumer_impl, consumer_group_name, topic_names, consumer_group_opts]
      ),
      # Start your own worker by calling: KafkaCounter.Worker.start_link(arg1, arg2, arg3)
      # worker(KafkaCounter.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KafkaCounter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KafkaCounterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
