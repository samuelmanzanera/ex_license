# ExLicense

Utility to insert license header in each Elixir file using SPDX specification.

A mix task is available to insert header or to verify (useful for CI actions)

```sh
$ mix insert_license --license mit
```

```sh
$ mix insert_license --verify --license mit
```

Here, the `--license` option takes one of these values `mit, agpl, gpl, lgpl, mozilla, apache, boost`

## Installation

Install from [Hex](https://hex.pm/packages/ex_license), the package can be installed
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

- [x] [mit](https://spdx.org/licenses/MIT.html)
- [x] [agpl_v3](https://spdx.org/licenses/AGPL-3.0-or-later.html)
- [x] [gpl_v3](https://spdx.org/licenses/GPL-3.0-or-later.html)
- [x] [lgpl_v3](https://spdx.org/licenses/LGPL-3.0-or-later.html)
- [x] [mozilla_v2](https://spdx.org/licenses/MPL-2.0.html)
- [x] [apache_v2](https://spdx.org/licenses/Apache-2.0.html)
- [x] [boost_v1](https://spdx.org/licenses/BSL-1.0.html)

Documentation published on [HexDocs](https://hexdocs.pm/ex_license). 
