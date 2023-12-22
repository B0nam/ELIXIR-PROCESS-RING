defmodule ProcessRing do

  @doc "Creates processes with the given size."
  def create_processes(size) do
    1..size |> Enum.map(fn _ -> spawn(fn -> process_listener() end) end)
  end

  @doc "Creates a ring from a list of processes setting their position."
  def create_ring(processes_list) do
    Enum.with_index(processes_list)
    |> Enum.map(fn {process, position} ->
      next_process_pid = Enum.at(processes_list, position + 1)
      first_ring_process = Enum.at(processes_list, 0)
      if next_process_pid do
        %{pid: process, position: position, next_process: next_process_pid}
      else
        %{pid: process, position: position, next_process: first_ring_process}
      end
    end)
  end

  @doc "Starts the ring by sending a message to the first process."
  def start_ring(ring) do
    first_ring_process = Enum.at(ring, 0).pid
    ring_size = Enum.count(ring)
    send_message(first_ring_process, ring, (ring_size - 1))
  end

  @doc "Listens for messages and forwards them to the next process in the ring."
  def process_listener() do
    receive do
      {:message, ring, sender_position} ->
        actual_process_position = rem(sender_position + 1, Enum.count(ring))
        next_process_pid = Enum.at(ring, actual_process_position).next_process

        :timer.sleep(1000) # 1 second delay between messages

        send_message(next_process_pid, ring, actual_process_position)
        process_listener()
      end
  end

  @doc "Send a message to the given pid an showing a sort of log"
  def send_message(process_pid, ring, position) do
    send(process_pid, {:message, ring, position})

    if position == 0 do
      IO.puts("\n[+] New Cycle Started.")
    end

    IO.puts("[.] #{inspect(self())} SENT A MESSAGE TO #{inspect(process_pid)}")
  end
end
