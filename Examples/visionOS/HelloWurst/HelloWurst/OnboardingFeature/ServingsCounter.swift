import SwiftUI

struct ServingsCounter: View {
  
  @Environment(OnboardingFeatureModel.self)
  var model
  
  var body: some View {
    List {
      Section {
        VStack {
          Spacer()
          ServingsPicker(size: 50)
        }
        .padding(.horizontal)
        .listRowSeparator(.hidden)
      } header: {
        VStack {
          Spacer()
            .frame(width: .zero, height: 0)
            .accessibilityLabel("Step 3 of 4")
          
          Text("How many servings do you usually cook?")
            .font(.system(.title, design: .serif))
            .bold()
          
          Text("You can change your serving count at any time.")
            .fontWeight(.regular)
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.primary)
        .padding(.bottom, 30)
        .multilineTextAlignment(.center)
        .accessibilityAddTraits(.isHeader)
        .accessibilityElement(children: .combine)
      }
    }
    .listStyle(.plain)
    .toolbar {
      ToolbarItem(placement: .bottomBar) {
        Button(
          action: { model.displayAlmostThere() },
          label: {
            Text("Continue".uppercased())
              .frame(maxWidth: .infinity)
          }
        )
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
      }
    }
  }
}

#Preview {
  NavigationStack {
    ServingsCounter()
      .environment(OnboardingFeatureModel())
      .environment(Preferences())
  }
}



