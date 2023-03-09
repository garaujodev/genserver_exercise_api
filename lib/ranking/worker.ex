defmodule Ranking.Worker do
  @moduledoc """
  This module is responsible for the GenServer callbacks and handles

  As mentioned in the GenServer docs:
  In practice, it is common to have both server and client functions in the same module. 
  If the server and/or client implementations are growing complex, you may want to have them in different modules.
  """

  require Logger

  use GenServer

  alias Ranking.Accounts

  @random_number_range 0..100

  # 1 minute
  @interval 60 * 1000

  defstruct [:min_number, :timestamp]

  @type t :: %__MODULE__{
          min_number: integer,
          timestamp: integer
        }

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc """
  GenServer.init/1 callback
  """
  @impl true
  def init(_) do
    schedule()

    {:ok, %__MODULE__{min_number: random_number(), timestamp: nil}}
  end

  @doc """
  GenServer.handle_info/2 callback
  """
  @impl true
  def handle_info(:work, %__MODULE__{min_number: _min_number, timestamp: timestamp}) do
    {:ok, _} = Accounts.update_users_points!()

    schedule()

    {:noreply, %__MODULE__{min_number: random_number(), timestamp: timestamp}}
  end

  @doc """
  GenServer.handle_call/3 callback
  """
  @impl true
  def handle_call(:get, _from, %__MODULE__{
        min_number: min_number,
        timestamp: timestamp
      }) do
    {:reply, %{users: Accounts.list_users(min_number), timestamp: timestamp},
     %__MODULE__{min_number: min_number, timestamp: timestamp_now()}}
  end

  def get, do: GenServer.call(__MODULE__, :get)

  defp schedule do
    Logger.info("Scheduling the next task run in #{@interval} ms")

    Process.send_after(self(), :work, @interval)
  end

  defp random_number, do: Enum.random(@random_number_range)
  defp timestamp_now, do: NaiveDateTime.utc_now()
end
