import Foundation
import SwiftUI

@Observable
class Preferences {
  var goals: Set<Goal> = []
  var diet: Diet?
  var servings: UInt = 2
}
