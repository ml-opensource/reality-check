import SwiftUI

func colorFromHash(_ input: String) -> Color {
  var hashCode = 0

  // Calculate the hash code from the input string
  for char in input.unicodeScalars {
    let charCode = Int(char.value)
    hashCode = ((hashCode << 5) &+ hashCode) &+ charCode
  }

  // Create a color from the hash code
  let red = Double((hashCode >> 16) & 0xFF) / 255.0
  let green = Double((hashCode >> 8) & 0xFF) / 255.0
  let blue = Double(hashCode & 0xFF) / 255.0

  return Color(red: red, green: green, blue: blue)
}
