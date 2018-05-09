# FuckFlake

Generates ids based on timestamp offset, node id, counter and random.
Instead of SnowFlake and SimpleFlake agorithms which values   are sequential it means they can be easely predicted and can't be directly used for data distribution.
In FuckFlake first bits are random that makes values dispersed on entire 64-bit interval

Value structure:

- 1..8: 8 bit random
- 9..16: 8 bit node counter
- 17..56: 40 bit microseconds since 2018-01-01
- 57..64: 8 bit node id

it allow take at least 256 collision guarantee values per node per microsecond. Can be increased using bits allocated for node id

## API

Containt methods for generate unsigned int64 values

> 0..18446744073709551615

and helpers to convert to signed in case of use with Postgres or other soft that does't support unsigned values

> -9223372036854775808..+9223372036854775807

### Generators

#### fuck()

> 2821789490373903361

Gen UInt64 id

#### fuck58()

> 'mAYmhY7GACg'

Gen UInt64 id Base58 encoded

### Helpers

#### to_sing(num)

    iex(55)> FuckFlake.fuck |> FuckFlake.to_sing
    -1859420847169712895

#### to_unsing(num)

    iex(56)> -1859420847169712895 |> FuckFlake.to_unsing
    7363951189685062913

#### int_to_b58(int)

    iex(57)> -1859420847169712895 |> FuckFlake.int_to_b58
    'J6RXjh7JYme'

#### uint_to_b58(uint)

    iex(59)> 7363951189685062913 |> FuckFlake.uint_to_b58
    'J6RXjh7JYme'

#### b58_to_int(b58)

    iex(60)> 'J6RXjh7JYme' |> FuckFlake.b58_to_uint
    7363951189685062913

#### b58_to_uint(b58)

    iex(61)> 'J6RXjh7JYme' |> FuckFlake.b58_to_int
    -1859420847169712895

 
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fuck_flake` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fuck_flake, "~> 0.1.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fuck_flake](https://hexdocs.pm/fuck_flake).

