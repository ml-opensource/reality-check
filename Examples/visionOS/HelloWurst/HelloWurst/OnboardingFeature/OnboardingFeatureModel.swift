import Foundation
import SwiftUI

@Observable
class OnboardingFeatureModel {
  
  enum Destination {
    case goals
    case diet
    case servings
    case almost
  }

  var navigationPath: [Destination] = []
  var onboardingDidComplete: () -> Void = {}
  var currentSlide = 0
  private(set) var isReady = false
  
  func displayGoalsSelector() {
    navigationPath.append(.goals)
  }
  
  func displayDietSelector() {
    navigationPath.append(.diet)
  }
  
  func displayServingsCounter() {
    navigationPath.append(.servings)
  }
  
  func displayAlmostThere() {
    navigationPath.append(.almost)
  }
  
  func nextSlide() {
    if currentSlide >= 2 {
      currentSlide = 0
    } else {
      currentSlide += 1
    }
  }
  
  func onboardingIsReady() {
    isReady = true
  }
}
