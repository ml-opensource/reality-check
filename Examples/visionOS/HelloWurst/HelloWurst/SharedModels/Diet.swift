import Foundation

enum Diet: String, CaseIterable, Identifiable {
  var id: Self { self }

  case everything = "I eat everything"
  case vegetarian = "Vegetarian"
  case vegan = "Vegan"
  case lowCarb = "Low carb"
  case mediterranean = "Mediterranean"
  case pescetarian = "Pescetarian"
  case paleo = "Paleo"
  case keto = "Keto"
  case highProtein = "High protein"
}

extension Diet {
  var systemImage: String {
    switch self {
    case .everything:
      "hare"
    case .vegetarian:
      "leaf"
    case .vegan:
      "laurel.trailing"
    case .lowCarb:
      "moon.circle"
    case .mediterranean:
      "sun.horizon"
    case .pescetarian:
      "fish"
    case .paleo:
      "fossil.shell"
    case .keto:
      "drop"
    case .highProtein:
      "atom"
    }
  }
}

extension Diet {
  var isIncludedInFreeVersion: Bool {
    switch self {
    case .everything:
      true
    case .vegetarian:
      true
    case .vegan:
      false
    case .lowCarb:
      false
    case .mediterranean:
      false
    case .pescetarian:
      false
    case .paleo:
      false
    case .keto:
      false
    case .highProtein:
      false
    }
  }
}
