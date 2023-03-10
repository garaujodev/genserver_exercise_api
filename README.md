# Description 

This is just a proof of concept using GenServer.

When started, this application will start a [GenServer](https://hexdocs.pm/elixir/1.14.3/GenServer.html) that runs in every __1 minute__ and:
* Update all `points` field from `users` table to a random number [0-100].

_DISCLAIMER_: As you can see, we have some modules and functions that we are not using right now, but I prefer to keep it cause I intend to work in some enhancements/POCs later.

# Setup

## Requirements
  * Elixir  (I recommend 1.14.3 or above)
  * Postgres (I recommend 12.8 or above)

To setup the application, you will need run the following
```bash
$ mix setup
  # or
$ mix deps.get ecto.setup
```
It will automatically install all dependencies and run database related tasks, such the seed of 1.000.000 (1 milion) of users to the database.

_FYI: The database size will be something like 80MB._

## Usage

To start your server:

  * Start with `mix phx.server` or inside IEx with `iex -S mix phx.server`

This application only have 1 route (the root `/`): 
* Returns a JSON with maximum of 2 users and a timestamp
  * The timestamp indicates the last time someone queried the GenServer (defaults to `nil` for the first query)

```bash
$ curl http://localhost:4000/

{"timestamp":"2023-03-07T21:50:17.196637","users":[{"id":859008,"points":83},{"id":859058,"points":81}]}
```

_Note: For the first time executing this application, requests right after the application start may won't return users. You need to wait the GenServer to update points first to do that. The query only returns users with more points than a random number, and at this time, all users will have 0 points._

## Tests

You can run the test suit with the following command
```bash
mix test
```
