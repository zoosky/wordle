import gleam/string
import gleam/int
import gleam/list

pub const bold = 1

pub const black = 30

pub const green = 32

pub const green_bg = 42

pub const gray = 90

pub const yellow = 33

pub const yellow_bg = 43

pub fn seq(codes: List(Int)) -> fn(String) -> String {
  let start_sequence =
    codes
    |> list.map(int.to_string)
    |> string.join(";")
  fn(s) { string.concat(["\u{001b}[", start_sequence, "m", s, "\u{001b}[0m"]) }
}
