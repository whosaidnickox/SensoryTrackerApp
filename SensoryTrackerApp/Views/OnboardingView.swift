import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    @State private var currentIndex = 0

    private let totalPages = 4

    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button("Skip") {
                    hasSeenOnboarding = true
                }
                .font(.system(size: 18, weight: .bold))
                                   .foregroundColor(.white)
                                   .padding(.vertical, 14)
                                   .padding(.horizontal, 20)
                                   .background(Color(red: 0.4235, green: 0.8078, blue: 1.0))
                                   .cornerRadius(30)
             }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            Spacer()
            TabView(selection: $currentIndex) {
                ForEach(0..<totalPages, id: \.self) { index in
                    OnboardingPage(index: index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .animation(.easeInOut, value: currentIndex)
            .frame(maxHeight: .infinity )

            Spacer()

            HStack {
                 
                Spacer()
                Button(currentIndex == totalPages - 1 ? "Start" : "Next") {
                    if currentIndex < totalPages - 1 {
                        currentIndex += 1
                    } else {
                        hasSeenOnboarding = true
                    }
                }
                .font(.system(size: 18, weight: .bold))
                                   .foregroundColor(.white)
                                   .padding(.vertical, 14)
                                   .frame(maxWidth: .infinity)
                                   .background(Color(red: 0.4235, green: 0.8078, blue: 1.0))
                                   .cornerRadius(30)
                                   .padding(.horizontal, 32)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 13 / 255, green: 184 / 255, blue: 254 / 255), // голубой
                    Color(red: 0 / 255, green: 25 / 255, blue: 125 / 255)    // тёмно-синий
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .adpeiwqozpr()
    }
}
