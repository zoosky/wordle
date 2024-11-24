import gleam/dict
import gleam/list
import gleam/result
import gleam/string

pub opaque type Counter(k) {
  Counter(map: dict.Dict(k, Int))
}

pub fn new() -> Counter(k) {
  Counter(dict.new())
}

pub fn from_string(s: String) -> Counter(String) {
  string.to_graphemes(s)
  |> list.fold(dict.new(), fn(counter, char) {
    let current = dict.get(counter, char) |> result.unwrap(0)
    dict.insert(counter, char, current + 1)
  })
  |> Counter
}

pub fn to_map(c: Counter(k)) -> dict.Dict(k, Int) {
  c.map
}

pub fn has(c: Counter(k), k: k) -> Bool {
  dict.get(c.map, k)
  |> result.unwrap(0)
  |> fn(n) { n > 0 }
}

pub fn decrement(c: Counter(k), k: k) -> Counter(k) {
  let current = dict.get(c.map, k) |> result.unwrap(0)
  dict.insert(c.map, k, current - 1)
  |> Counter
}
