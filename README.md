# ExLicense

Utility to insert license header in each Elixir file using SPDX specification.

A mix task is available to insert header or to verify (useful for CI actions)


```
$ mix insert_license --licence mit
```

```
mix insert_licence --verify --license mit
```


## Installation

If [available in Hex](https://hex.pm/ex_license), the package can be installed
by adding `ex_license` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_license, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/samuelmanzanera/ex_license)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_license](https://hexdocs.pm/ex_license).

