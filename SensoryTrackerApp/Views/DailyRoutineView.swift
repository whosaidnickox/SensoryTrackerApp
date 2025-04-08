import SwiftUI

struct RoutineItem: Identifiable {
    let id = UUID()
    let time: String
    let title: String
    let icon: String
    let color: Color
    var isCompleted: Bool
}

struct DailyRoutineView: View {
    @State private var routineItems: [RoutineItem] = [
        RoutineItem(time: "07:00", title: "Awakening", icon: "alarm", color: Color(red: 0.5, green: 0.7, blue: 0.9), isCompleted: true),
        RoutineItem(time: "07:30", title: "Wash up", icon: "drop", color: .indigo, isCompleted: false),
        RoutineItem(time: "08:00", title: "Breakfast", icon: "cup.and.saucer", color: Color(red: 0.6, green: 0.4, blue: 0.2), isCompleted: false),
        RoutineItem(time: "08:30", title: "Going to school", icon: "house", color: .orange, isCompleted: false),
        RoutineItem(time: "12:00", title: "Lunch", icon: "fork.knife", color: .purple, isCompleted: false),
        RoutineItem(time: "14:30", title: "Household chores", icon: "checklist", color: Color(red: 0.4, green: 0.5, blue: 0.6), isCompleted: false),
        RoutineItem(time: "16:00", title: "Walking", icon: "figure.walk", color: Color(red: 0.6, green: 0.5, blue: 0.3), isCompleted: false),
        RoutineItem(time: "18:00", title: "Exercise", icon: "dumbbell", color: Color(red: 0.6, green: 0.5, blue: 0.3), isCompleted: false),
        RoutineItem(time: "19:00", title: "Dinner", icon: "fork.knife", color: Color(red: 0.7, green: 0.8, blue: 0.9), isCompleted: false),
        RoutineItem(time: "21:00", title: "Sleep", icon: "bed.double", color: .indigo, isCompleted: false)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Daily routine")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 40)
                .padding(.bottom, 30)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach($routineItems) { $item in
                        HStack {
                            Text(item.time)
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white)
                                .frame(width: 60, alignment: .leading)
                            
                            HStack {
                                Image(systemName: item.icon)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .frame(width: 30)
                                
                                Text(item.title)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.spring()) {
                                        item.isCompleted.toggle()
                                    }
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)  // Белый фон круга
                                            .frame(width: 24, height: 24)
                                        
                                        Circle()
                                            .stroke(Color(red: 108/255, green: 206/255, blue: 255/255), lineWidth: 1)  // Обводка круга
                                            .frame(width: 24, height: 24)
                                        
                                        if item.isCompleted {
                                            Image(systemName: "checkmark")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 12, height: 12)
                                                .foregroundColor(.black)  // Галочка белого цвета
                                        }
                                    }

                                }
                                .buttonStyle(PlainButtonStyle()) // Убирает анимацию нажатия по умолчанию
                            }

                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(item.color)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 108/255, green: 206/255, blue: 255/255), lineWidth: 1)
                            )
                        }
                         .padding(.horizontal)
                    }
 
                }
                .padding(.bottom, 100)
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
    }
}
 

struct DailyRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        DailyRoutineView()
    }
} 
