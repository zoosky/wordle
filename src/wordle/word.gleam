import gleam/string
import gleam/list

pub opaque type Word {
  Word(word: String)
}

pub type NewWordError {
  InvalidLengthError
  InvalidCharactersError
}

fn is_alpha(char: String) -> Bool {
  let assert Ok(code) = string.to_utf_codepoints(char)
    |> list.first
  string.utf_codepoint_to_int(code) >= 97 && 
    string.utf_codepoint_to_int(code) <= 122 || 
    string.utf_codepoint_to_int(code) >= 65 && 
    string.utf_codepoint_to_int(code) <= 90
}

pub fn new(word: String) -> Result(Word, NewWordError) {
  let trimmed = string.trim(word)
  case string.length(trimmed) {
    5 -> {
      // Check if all characters are alphabetic
      case
        string.to_graphemes(trimmed)
        |> list.all(is_alpha)
      {
        True -> Ok(Word(string.lowercase(trimmed)))
        False -> Error(InvalidCharactersError)
      }
    }
    _ -> Error(InvalidLengthError)
  }
}

pub fn reveal(w: Word) -> String {
  w.word
}
