import SwiftUI

//enum Tab: String, CaseIterable {
//    case coloring = "Coloring"
//     case sensory = "Sensory"
//    case stats = "Stats"
//    case emotions = "Emotions"
//
//    
//    var systemImage: String {
//        switch self {
//        case .coloring: return "Draw"
//         case .sensory: return "Pulse"
//        case .stats: return "Notice"
//        case .emotions: return "Emoji"
//
//        }
//    }
//    
//    var color: Color {
//        switch self {
//        case .coloring: return .blue
//        case .emotions: return .pink
//        case .sensory: return .purple
//        case .stats: return .orange
//        }
//    }
//}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private let circleSize: CGFloat = 60
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                VStack(spacing: 4) {
                    ZStack {
                         Image(tab.systemImage)
                            .font(.system(size: 24))
                            .foregroundColor(selectedTab == tab ? tab.color : .gray)
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = tab
                        }
                    }
                 }
                Spacer()
            }
        }
        .frame(height: 65)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.153, green: 0.6, blue: 0.922))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
        )
    }
} 
