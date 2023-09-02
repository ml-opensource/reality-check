import Foundation
import SwiftUI

@Observable
class StepByStepFeatureModel {
  var steps: [Recipe.Step]
  var current: Recipe.Step
  var didComplete: () -> Void

  init(
    steps: [Recipe.Step],
    didComplete: @escaping () -> Void =  {}
  ) {
    self.steps = steps
    self.current = steps[0]
    self.didComplete = didComplete
  }
}
