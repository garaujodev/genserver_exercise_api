defmodule Ranking.WorkerTest do
  use ExUnit.Case

  import ExUnit.CaptureLog

  alias Ranking.Worker

  describe "init/1" do
    test "The worker starts with nil timestamp" do
      assert {:ok, %Worker{min_number: _number, timestamp: nil}} = Worker.init([])
    end

    test "The worker schedule the next task run" do
      assert capture_log(fn -> Worker.init([]) end) =~ "Scheduling the next task"
    end
  end
end
