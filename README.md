# ELIXIR-PROCESS-RING

 Process ring implemented in Elixir using processeses. 

## Overview

This project implements a process ring in Elixir. A process ring is a system of concurrent processes, where each process is linked to its next neighbor in a circular manner. The processes communicate by passing messages in a ring fashion.

## Usage

To create the process ring, follow these steps:

1. Open process_ring.exs using iex:

    ```bash
    iex process_ring.exs
    ```

2. Create a list of processes using create_processes():

    ```elixir
    process_list = ProcessRing.create_processes(10) # Replace 10 with the desired number of processes
    ```

3. Create a process ring using create_ring()

    ```elixir
    ring = ProcessRing.create_ring(process_list) # Use the list of processes created previously
    ```

4. Start the ring:

    ```elixir
    ProcessRing.start_ring(ring)
    ```

## Project Structure

- `ProcessRing.ex`: Contains the main module defining functions for creating processes, building the ring, starting the ring, and handling message passing.

## Functions

### `create_processes(size)`

Creates processes with the given size.

### `create_ring(processes_list)`

Creates a ring from a list of processes, setting their positions on the ring.

### `start_ring(ring)`

Starts the ring by sending a message to the first process.

### `process_listener()`

Listens for messages and forwards them to the next process in the ring.

### `send_message(process_pid, ring, position)`

Sends a message to the given process ID, displaying a log. If the position is 0, it indicates the start of a new cycle.

Certainly! I've refined the example session and separated it into sections with explanations:

## Example

### 1. Create Processes

```elixir
iex(1)> process_list = ProcessRing.create_processes(10)
[#PID<0.116.0>, #PID<0.117.0>, #PID<0.118.0>, #PID<0.119.0>, #PID<0.120.0>, #PID<0.121.0>, #PID<0.122.0>, #PID<0.123.0>, #PID<0.124.0>, #PID<0.125.0>]
```

In this step, we create a list of 10 processes. Each process is represented by a unique PID.

### 2. Create Process Ring

```elixir
iex(2)> ring = ProcessRing.create_ring(process_list)
[
  %{pid: #PID<0.116.0>, position: 0, next_process: #PID<0.117.0>},
  %{pid: #PID<0.117.0>, position: 1, next_process: #PID<0.118.0>},
  %{pid: #PID<0.118.0>, position: 2, next_process: #PID<0.119.0>},
  %{pid: #PID<0.119.0>, position: 3, next_process: #PID<0.120.0>},
  %{pid: #PID<0.120.0>, position: 4, next_process: #PID<0.121.0>},
  %{pid: #PID<0.121.0>, position: 5, next_process: #PID<0.122.0>},
  %{pid: #PID<0.122.0>, position: 6, next_process: #PID<0.123.0>},
  %{pid: #PID<0.123.0>, position: 7, next_process: #PID<0.124.0>},
  %{pid: #PID<0.124.0>, position: 8, next_process: #PID<0.125.0>},
  %{pid: #PID<0.125.0>, position: 9, next_process: #PID<0.116.0>}
]
```

Here, we create a process ring using the previously generated list of processes. Each entry in the list represents a process in the ring, with information about its PID, position, and the PID of its next neighbor.

### 3. Start the Process Ring

```elixir
iex(3)> ProcessRing.start_ring(ring)
[.] #PID<0.115.0> SENT A MESSAGE TO #PID<0.116.0>
:ok

[+] New Cycle Started.
[.] #PID<0.116.0> SENT A MESSAGE TO #PID<0.117.0>
[.] #PID<0.117.0> SENT A MESSAGE TO #PID<0.118.0>
[.] #PID<0.118.0> SENT A MESSAGE TO #PID<0.119.0>
[.] #PID<0.119.0> SENT A MESSAGE TO #PID<0.120.0>
[.] #PID<0.120.0> SENT A MESSAGE TO #PID<0.121.0>
[.] #PID<0.121.0> SENT A MESSAGE TO #PID<0.122.0>
[.] #PID<0.122.0> SENT A MESSAGE TO #PID<0.123.0>
[.] #PID<0.123.0> SENT A MESSAGE TO #PID<0.124.0>
[.] #PID<0.124.0> SENT A MESSAGE TO #PID<0.125.0>
[.] #PID<0.125.0> SENT A MESSAGE TO #PID<0.116.0>

[+] New Cycle Started.
[.] #PID<0.116.0> SENT A MESSAGE TO #PID<0.117.0>
[.] #PID<0.117.0> SENT A MESSAGE TO #PID<0.118.0>
[.] #PID<0.118.0> SENT A MESSAGE TO #PID<0.119.0>
...
```

Finally, we start the process ring, and you can observe the messages being passed between processes. A new cycle starts after each round, demonstrating the circular communication pattern.