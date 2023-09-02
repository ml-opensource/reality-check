import Foundation

enum Goal: String, CaseIterable, Identifiable {
  var id: Self { self }

  case inspiration = "Find recipe inspiration"
  case health = "Eat healthier"
  case learn = "Learn how to cook"
  case diet = "Follow a certain diet"
  case plan = "Plan my meals"
  case time = "Save time"
  case money = "Save money"
  case other = "Other"
}

extension Goal {
  var systemImage: String {
    switch self {
    case .inspiration:
      "lightbulb.led"
    case .health:
      "carrot"
    case .learn:
      "graduationcap"
    case .diet:
      "frying.pan"
    case .plan:
      "calendar"
    case .time:
      "clock"
    case .money:
      "banknote"
    case .other:
      "laurel.leading"
    }
  }
}
