import Foundation
import SwiftUI
import UIKit

@Observable
class AppCoreFeatureModel {
  var destination: Destination
  var onboardingModel: OnboardingFeatureModel
  var isOnboadingPresented: Bool {
    get {
      self.destination == .onboarding
    }
    set {
      displayMain()
    }
  }
  let recipes: [Recipe]
  var selectedRecipe: Recipe?
  var isStepByStepPresented: Bool = false
  
  init(
    destination: Destination = .onboarding,
    onboardingModel: OnboardingFeatureModel = OnboardingFeatureModel(),
    recipes: [Recipe] = []
  ) {
    self.destination = destination
    self.onboardingModel = onboardingModel
    self.recipes = recipes
    self.bind()
  }
  
  private func bind() {
    self.onboardingModel.onboardingDidComplete = {
      self.displayMain()
    }
  }
  
  func displayOnboarding() {
    destination = .onboarding
  }
  
  func displayMain() {
    destination = .main
  }
  
  func displayStepByStep(recipe: Recipe) {
    isStepByStepPresented = true
    selectedRecipe = recipe
    requestLandscape()
  }
  
  func hideStepByStep() {
    isStepByStepPresented = false
    selectedRecipe = nil
    requestPortrait()
  }
  
  private func requestLandscape() {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
      return
    }
    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
  }
  
  private func requestPortrait() {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
      return
    }
    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
  }
}
