import Foundation

extension String {
  func withFirstLetterUppercased() -> String {
    if let firstLetter = self.first {
      return firstLetter.uppercased() + self.dropFirst()
    } else {
      return self
    }
  }
}

extension String {
  func withFirstLetterLowercased() -> String {
    if let firstLetter = self.first {
      return firstLetter.lowercased() + self.dropFirst()
    } else {
      return self
    }
  }
}
