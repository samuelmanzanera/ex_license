# ExLicense

Utility to insert license header in each Elixir file using SPDX specification.

A mix task is available to insert header or to verify (useful for CI actions)

```
$ mix insert_license --license mit
```

```
mix insert_license --verify --license mit
```

## Installation

Install from [Hex](https://hex.pm/ex_license), the package can be installed
by adding `ex_license` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_license, "~> 0.1.0"}
  ]
end
```

## Available License

It supports the following license

- [x] mit
- [x] agpl_v3
- [x] gpl_v3
- [x] lgpl_v3
- [x] mozilla_v2
- [x] apache_v2
- [x] boost_v1

Documentation can be generated with [ExDoc](https://github.com/samuelmanzanera/ex_license)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_license](https://hexdocs.pm/ex_license).
