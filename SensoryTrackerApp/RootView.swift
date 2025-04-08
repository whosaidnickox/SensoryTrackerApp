import SwiftUI

struct RootView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false

    var body: some View {
        if hasSeenOnboarding {
            MainTabView()
        } else {
            OnboardingView()
        }
    }
}
