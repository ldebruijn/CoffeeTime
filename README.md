# Coffeetime

An app that uses the Webhook mechanism of Google to post a notification in the morning with a random Giphy in order to stimulate the 'Coffeetime' we had back when we could work in the office pre-corona times.

This application is a super simpel, non-showcase application. It was written with three specific purposes in mind:
* Firstly, I wanted to try out Elixir. This is the first app I've ever written in the language and as such, I have much to learn
* I have a Raspberry Pi collecting dust in a drawer. I've installed K3s on it and wanted to give that a spin.
* If I'm going to invest some time in a project I want it to be atleast somewhat useful, hence the very specific use case this application fulfills.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `coffeetime` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:coffeetime, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/coffeetime](https://hexdocs.pm/coffeetime).

## Installing dependencies

Install dependencies by executing

```
  mix.deps.get
```

## Running locally

```
  CT_GIPHY_API_KEY= \
  CT_GCHAT_KEY= \
  CT_GCHAT_TOKEN= \
  CT_GCHAT_ROOM_KEY= \
  CT_CHAT_ROOM= \
  mix run --config config/releases.exs
```

## Building a release

```
  MIX_ENV=prod mix release
```

## Running a release

Pass the required environment variables to the process when starting it, i.e.

```
  CT_GIPHY_API_KEY= \
  CT_GCHAT_KEY= \
  CT_GCHAT_TOKEN= \
  CT_GCHAT_ROOM_KEY= \
  CT_CHAT_ROOM= \
  T_KEY_build/prod/rel/coffeetime/bin/coffeetime start
```

## Starting interactive session

Start an interactive terminal session by executing

```
  iex -S mix
```

When making changes, recompile the changes by entering the following in the shell

```
  recompile()
```

And run the program with

```
  CoffeeTime.start()
```