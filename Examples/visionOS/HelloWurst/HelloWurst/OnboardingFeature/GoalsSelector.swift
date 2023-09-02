import SwiftUI

struct GoalsSelector: View {
  
  @Environment(OnboardingFeatureModel.self)
  var model
  
  @Environment(Preferences.self)
  var preferences
  
  var body: some View {
    List {
      Section {
        ForEach(Goal.allCases) { goal in
          let isSelected = preferences.goals.contains(goal)
          Button(
            action: {
              if isSelected {
                preferences.goals.remove(goal)
              } else {
                preferences.goals.insert(goal)
              }
            },
            label: {
              Label(goal.rawValue, systemImage: goal.systemImage)
                .accessibilityLabel(goal.rawValue + (isSelected ? ". selected" : ""))
            }
          )
          .tag(goal)
          .listItemTint(isSelected ? Color.primary : .accentColor)
          .listRowBackground(isSelected ? Color.accentColor : .clear )
          .accessibilityAction(named: "Continue") {
            model.displayDietSelector()
          }
        }
      } header: {
        VStack {
          Spacer()
            .frame(width: .zero, height: 0)
            .accessibilityLabel("Step 1 of 4")
          
          Text("What brings you to Hello Würst?")
            .font(.system(.title, design: .serif))
            .bold()
          
          Text("We base our recipe recommendations on your goals.")
            .fontWeight(.regular)
        }
        .foregroundStyle(.primary)
        .padding(.bottom, 30)
        .multilineTextAlignment(.center)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
        .accessibilityHint("You can choose multiple goals from the list")
      }
    }
    .listStyle(.plain)
    .toolbar {
      ToolbarItem(placement: .bottomBar) {
        Button(
          action: { model.displayDietSelector() },
          label: {
            Text("Continue".uppercased())
              .frame(maxWidth: .infinity)
          }
        )
        .disabled(preferences.goals.isEmpty)
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
      }
    }
    .toolbar {
      ToolbarItem {
        Button("Skip") { model.displayDietSelector() }
      }
    }
  }
}

#Preview {
  NavigationStack {
    GoalsSelector()
      .environment(OnboardingFeatureModel())
      .environment(Preferences())
  }
}
