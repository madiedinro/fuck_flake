# FuckLake

**TODO: Add description**


## Examples 

    iex(15)> FuckLake.fuck
    16360734652784538881

    iex(13)> FuckLake.fuck |> FuckLake.uid_to_b58
    'mAYmhY7GACg'
    
    iex(16)> FuckLake.fuck58
    '8hnj7B4HKTe'
    
    iex(17)> FuckLake.fuck58 |> FuckLake.b58_to_uid
    -3958943915941350911
    
to int 64 with sign (for usage in postgres, etc...)

    iex(21)> FuckLake.fuck |> FuckLake.to_sing
    1878847101064396289
    
    iex(22)> FuckLake.fuck |> FuckLake.to_sing
    -6119264362168704511



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fuck_flake` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fuck_lake, "~> 0.1.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fuck_flake](https://hexdocs.pm/fuck_flake).

