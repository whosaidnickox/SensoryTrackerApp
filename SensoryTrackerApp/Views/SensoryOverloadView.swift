import SwiftUI

struct SensoryOverloadView: View {
    @State private var sensoryInputs: [SensoryInput] = [
        SensoryInput(name: "Brightly", icon: "Brightly", isActive: false),
        SensoryInput(name: "Loudly", icon: "Loudly", isActive: false),
        SensoryInput(name: "Crowd", icon: "Crowd", isActive: false),
        SensoryInput(name: "Stress", icon: "Stress", isActive: false),
        SensoryInput(name: "Hot", icon: "Hot", isActive: false),
        SensoryInput(name: "Cold", icon: "Cold", isActive: false),
        SensoryInput(name: "Talking", icon: "Talking", isActive: false),
        SensoryInput(name: "Sad", icon: "Sad", isActive: false),
        SensoryInput(name: "Fun", icon: "Fun", isActive: false),
        SensoryInput(name: "Comfortable", icon: "Comfortable", isActive: false)
    ]
    
    @State private var showingStatistics = false
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Sensory Overload\nTracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
//                   Image(systemName: "chart.bar.fill")
//                    .font(.title2)
            }
            .padding(.horizontal)
            HStack{
                Spacer()

                Button(action: {
                    withAnimation {
                        showingStatistics = true
                    }
                }) {
                    Image("Graf")
                        .font(.title3)
                        .padding(10)
                        .padding(.horizontal, 5)
                        .background(Color(red: 0.11, green: 0.71, blue: 1.0))
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal, 40)
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach($sensoryInputs) { $input in
                        SensoryInputRow(input: $input)
                    }
                }
//                .padding(.vertical)
            }
            
            Button(action: {
                // Handle need a break action
            }) {
                Text("Need a break")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.11, green: 0.71, blue: 1.0))
                    .cornerRadius(42)
            }
            .padding(.horizontal)
            .padding(.bottom, 50)
            
//            // Bottom Tab Bar
//            HStack(spacing: 40) {
//                Image(systemName: "pencil")
//                Image(systemName: "waveform.path")
//                Image(systemName: "list.bullet")
//                Image(systemName: "face.smiling")
//            }
//            .font(.title2)
//            .foregroundColor(.white)
//            .padding()
//            .background(Color.blue.opacity(0.3))
//            .cornerRadius(20)
//            .padding()
        }
        .fullScreenCover(isPresented: $showingStatistics) {
            StatisticsView(isPresented: $showingStatistics)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 13/255, green: 184/255, blue: 254/255),
                    Color(red: 0/255, green: 25/255, blue: 125/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

struct SensoryInput: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var isActive: Bool
}

struct SensoryInputRow: View {
    @Binding var input: SensoryInput

    var body: some View {
        Button(action: {
            withAnimation {
                input.isActive.toggle()
            }
        }) {
            HStack {
                Image(input.icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 30)
                    .padding(.leading, 10)
                Text(input.name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.black)

                Spacer()

                ZStack {
                    Circle()
                        .stroke(Color.blue, lineWidth: 2)
                        .frame(width: 16, height: 16)

                    if input.isActive {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 16, height: 16)
                            .transition(.scale)
                    }
                }
                .padding(.trailing, 10)
                
            }
            .frame(minHeight: 39)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 1)
            .padding(.horizontal,40)
        }
        .buttonStyle(PlainButtonStyle()) // убирает эффект затемнения при нажатии
    }
}
