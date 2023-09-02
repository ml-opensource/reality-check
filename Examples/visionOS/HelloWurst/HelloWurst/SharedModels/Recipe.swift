import Foundation

struct Recipe: Identifiable {
  var id = UUID()

  let name: String
  let diet: Diet
  let image: String
  let time: Duration
  let price: Double

  let authors: [Author]
  let required: [Ingredient]
  let mightHave: [Ingredient]
  let nutritionFacts: [NutritionFact]
  let steps: [Step]
}

extension Recipe {
  struct Author: Identifiable {
    var id = UUID()

    let name: String
    let description: String?
    let source: URL
  }
}

extension Recipe {
  enum Amount {
    case mass(Measurement<UnitMass>)
    case subjective(String)
    case volume(Measurement<UnitVolume>)
  }
  struct Ingredient: Identifiable {
    var id = UUID()

    let amount: Amount
    let name: String
  }
}

extension Recipe.Amount {
  func formatted(servings: UInt) -> String {
    switch self {
    case .mass(let amount):
      let amountForServings = Measurement(value: amount.value * Double(servings), unit: amount.unit)
      return amountForServings.formatted()
      
    case .subjective(let amount):
      return amount
      
    case .volume(let amount):
      let amountForServings = Measurement(value: amount.value * Double(servings), unit: amount.unit)
      return amountForServings.formatted()
    }
  }
}

extension Recipe {
  enum NutritionFactType {
    case calorie(Measurement<UnitEnergy>)
    case protein(Measurement<UnitMass>)
    case fat(Measurement<UnitMass>)
    case carbohydrate(Measurement<UnitMass>)
  }

  struct NutritionFact: Identifiable {
    var id = UUID()

    let factType: NutritionFactType
  }
}

extension Recipe {
  struct Step: Identifiable, Hashable {
    var id = UUID()

    let name: String
    var time: Duration? = nil
  }
}
