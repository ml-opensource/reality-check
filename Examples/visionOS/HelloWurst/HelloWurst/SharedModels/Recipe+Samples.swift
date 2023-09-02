import Foundation

extension Recipe {
  static var samples = [
    Recipe(
      name: "Die einzig wahre Currywurst",
      diet: .everything,
      image: "classic-truck",
      time: .seconds(15 * 60),
      price: 7,
      authors: [
        Author(
          name: "Eugénie Brazie",
          description: "",
          source: URL(string: "https://en.wikipedia.org/wiki/Eugénie_Brazier")!
        )
      ],
      required: [
        Ingredient(amount: .mass(.init(value: 250, unit: .grams)), name: "Potatoes"),
        Ingredient(amount: .mass(.init(value: 75, unit: .grams)), name: "Tomato paste"),
      ],
      mightHave: [
        Ingredient(amount: .volume(.init(value: 250, unit: .milliliters)), name: "Water")
      ],
      nutritionFacts: [
        NutritionFact(factType: .calorie(.init(value: 707, unit: .calories))),
        NutritionFact(factType: .protein(.init(value: 37, unit: .grams))),
        NutritionFact(factType: .fat(.init(value: 28, unit: .grams))),
        NutritionFact(factType: .carbohydrate(.init(value: 77, unit: .grams))),
      ],
      steps: [
        .init(name: "1"),
        .init(name: "2"),
        .init(name: "3", time: .init(.seconds(60 * 3))),
        .init(name: "4"),
        .init(name: "5", time: .init(.seconds(60))),
        .init(name: "6"),
        .init(name: "7"),
      ]
    ),
    Recipe(
      name: "Gingery orange",
      diet: .vegan,
      image: "gingery-orange",
      time: .seconds(7 * 60),
      price: 13,
      authors: [
        Author(
          name: "Elena Arzak",
          description: "",
          source: URL(string: "https://en.wikipedia.org/wiki/Elena_Arzak")!
        )
      ],
      required: [
        Ingredient(amount: .mass(.init(value: 250, unit: .grams)), name: "Potatoes"),
        Ingredient(amount: .mass(.init(value: 10, unit: .grams)), name: "Ginger"),
      ],
      mightHave: [
        Ingredient(amount: .volume(.init(value: 250, unit: .milliliters)), name: "Water"),
        Ingredient(amount: .subjective("a pinch of"), name: "Salt"),
      ],
      nutritionFacts: [
        NutritionFact(factType: .calorie(.init(value: 707, unit: .calories))),
        NutritionFact(factType: .protein(.init(value: 37, unit: .grams))),
        NutritionFact(factType: .fat(.init(value: 28, unit: .grams))),
        NutritionFact(factType: .carbohydrate(.init(value: 77, unit: .grams))),
      ],
      steps: [
        .init(name: "1"),
        .init(name: "2"),
        .init(name: "3"),
        .init(name: "4"),
        .init(name: "5"),
        .init(name: "6"),
        .init(name: "7"),
        .init(name: "8"),
        .init(name: "9"),
        .init(name: "10"),
        .init(name: "11"),
      ]
    ),
    Recipe(
      name: "Green coconut",
      diet: .vegetarian,
      image: "green-coconut",
      time: .seconds(23 * 60),
      price: 15,
      authors: [
        Author(
          name: "Marie Bourgeois",
          description: "",
          source: URL(string: "https://en.wikipedia.org/wiki/Marie_Bourgeois")!
        )
      ],
      required: [
        Ingredient(amount: .mass(.init(value: 250, unit: .grams)), name: "Potatoes"),
        Ingredient(amount: .mass(.init(value: 10, unit: .grams)), name: "Cilantro fresh"),
        
      ],
      mightHave: [
        Ingredient(amount: .volume(.init(value: 250, unit: .milliliters)), name: "Water")
      ],
      nutritionFacts: [
        NutritionFact(factType: .calorie(.init(value: 707, unit: .calories))),
        NutritionFact(factType: .protein(.init(value: 37, unit: .grams))),
        NutritionFact(factType: .fat(.init(value: 28, unit: .grams))),
        NutritionFact(factType: .carbohydrate(.init(value: 77, unit: .grams))),
      ],
      steps: [
        .init(name: "1"),
        .init(name: "2"),
        .init(name: "3"),
        .init(name: "4"),
        .init(name: "5"),
        .init(name: "6"),
        .init(name: "7"),
        .init(name: "8"),
        .init(name: "9"),
      ]
    ),
    Recipe(
      name: "Honey mustard",
      diet: .mediterranean,
      image: "honey-mustard",
      time: .seconds(7 * 60),
      price: 9,
      authors: [
        Author(
          name: "Marguerite Bise",
          description: "",
          source: URL(string: "https://en.wikipedia.org/wiki/Marguerite_Bise")!
        )
      ],
      required: [
        Ingredient(amount: .mass(.init(value: 250, unit: .grams)), name: "Potatoes"),
        Ingredient(amount: .subjective("◐"), name: "Yellow onion"),
        Ingredient(amount: .mass(.init(value: 160, unit: .grams)), name: "Ground beef"),
      ],
      mightHave: [
        Ingredient(amount: .volume(.init(value: 250, unit: .milliliters)), name: "Water")
      ],
      nutritionFacts: [
        NutritionFact(factType: .calorie(.init(value: 707, unit: .calories))),
        NutritionFact(factType: .protein(.init(value: 37, unit: .grams))),
        NutritionFact(factType: .fat(.init(value: 28, unit: .grams))),
        NutritionFact(factType: .carbohydrate(.init(value: 77, unit: .grams))),
      ],
      steps: [
        .init(name: "1"),
        .init(name: "2"),
        .init(name: "3", time: .init(.seconds(60 * 5))),
        .init(name: "4"),
        .init(name: "5"),
        .init(name: "6"),
        .init(name: "7"),
        .init(name: "8"),
        .init(name: "9"),
        .init(name: "10"),
        .init(name: "11"),
        .init(name: "12"),
        .init(name: "13"),
      ]
    ),
    Recipe(
      name: "Radish arugula",
      diet: .everything,
      image: "radish-arugula",
      time: .seconds(9 * 60),
      price: 11,
      authors: [
        Author(
          name: "Sophie Bise",
          description: "",
          source: URL(string: "https://en.wikipedia.org/wiki/Sophie_Bise")!
        )
      ],
      required: [
        Ingredient(amount: .mass(.init(value: 250, unit: .grams)), name: "Potatoes"),
        Ingredient(amount: .mass(.init(value: 100, unit: .grams)), name: "greeb peas, frozen"),
      ],
      mightHave: [
        Ingredient(amount: .volume(.init(value: 250, unit: .milliliters)), name: "Water")
      ],
      nutritionFacts: [
        NutritionFact(factType: .calorie(.init(value: 707, unit: .calories))),
        NutritionFact(factType: .protein(.init(value: 37, unit: .grams))),
        NutritionFact(factType: .fat(.init(value: 28, unit: .grams))),
        NutritionFact(factType: .carbohydrate(.init(value: 77, unit: .grams))),
      ],
      steps: [
        .init(name: "1"),
        .init(name: "2"),
        .init(name: "3"),
        .init(name: "4"),
        .init(name: "5"),
      ]
    ),
  ]
}
