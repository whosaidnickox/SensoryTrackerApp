import SwiftUI

enum Tab: String, CaseIterable {
    case coloring = "Coloring"
     case sensory = "Sensory"
    case stats = "Stats"
    case emotions = "Emotions"
    
    var systemImage: String {
        switch self {
        case .coloring: return "Draw"
         case .sensory: return "Pulse"
        case .stats: return "Notice"
        case .emotions: return "Emoji"
        }
    }
    
    var color: Color {
        switch self {
        case .coloring: return .blue
        case .emotions: return .pink
        case .sensory: return .purple
        case .stats: return .orange
        }
    }
}

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
struct MainTabView: View {
    @State private var selectedTab: Tab = .coloring
    @State private var showingStatistics = false
    @State private var isTabBarVisible = true
    

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                TherapeuticColoringView(isTabBarVisible: $isTabBarVisible)
                    .tag(Tab.coloring)
 
                SensoryOverloadView()
                    .tag(Tab.sensory)
 
                DailyRoutineView()
                    .tag(Tab.stats)
 
                
                EmotionTrackerView()
                    .tag(Tab.emotions)
            }
            
            if isTabBarVisible {
                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
