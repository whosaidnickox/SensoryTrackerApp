import SwiftUI

struct Emotion: Codable, Equatable {
    let date: Date
    let type: EmotionType
}

enum EmotionType: String, Codable {
    case happy = "Happy"
    case calm = "Calm"
    case sad = "Sad"
    case angry = "Angry"
    
    var color: Color {
        switch self {
        case .happy: return .yellow
        case .calm: return .orange
        case .sad: return .blue
        case .angry: return .red
        }
    }
    
    var imageName: String {
        switch self {
        case .happy: return "happy"
        case .calm: return "calm"
        case .sad: return "sad"
        case .angry: return "angry"
        }
    }
    
    var description: String {
        switch self {
        case .happy: return "I'm feeling happy and energetic today!"
        case .calm: return "I'm feeling calm and peaceful today."
        case .sad: return "I'm feeling a bit down today."
        case .angry: return "I'm feeling frustrated and angry today."
        }
    }
}

struct EmotionTrackerView: View {
    @State private var selectedEmotion: EmotionType?
    @State private var showingEmotions = true
    @State private var savedEmotions: [Emotion] = []
    @State private var currentDate = Date()
    @State private var showingCalendar = false
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var body: some View {
             VStack(spacing: 20) {
                Text("Emotion tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                if !showingCalendar {
                    VStack{
                        Button(action: {
                            withAnimation {
                                showingCalendar.toggle()
                            }
                        }) {
                            HStack {
                                Spacer()
                                Image(systemName: "calendar")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding()
                                    .background(
                                      RoundedRectangle(cornerRadius: 20)
                                          .fill(Color(red: 0.153, green: 0.6, blue: 0.922))
                                          .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                                  )                             }
                        }
                        Text("\(calendar.component(.day, from: currentDate)) ,\(calendar.monthSymbols[calendar.component(.month, from: currentDate) - 1]) ,\(calendar.component(.year, from: currentDate))")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("How do you feel ?")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 40)
                    }
                    
                }else{
                    HStack{
                        Button(action: {
                            withAnimation {
                                showingCalendar.toggle()
                            }
                        }) {
                            HStack {
                                 Text("Back")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(20)
                         }
                        Spacer()
                    }
                    
                }
                if !showingCalendar{
                    if showingEmotions {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                           ForEach([EmotionType.happy, .calm, .sad, .angry], id: \.self) { emotion in
                               Button(action: {
                                   selectEmotion(emotion)
                               }) {
                                   VStack {
                                       Image(emotion.imageName)
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 80, height: 80)
                                           .padding()
                                           .background(Color.white)
                                           .cornerRadius(15)
                                   }
                               }
                           }
                       }
                       .padding()
                   } else if let emotion = selectedEmotion {
                       VStack(spacing: 30) {
                           Spacer()
                           Text(emotion.description)
                               .font(.title)
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                            Spacer()
                               Button(action: {
                               withAnimation {
                                   showingEmotions.toggle()
                               }
                           }) {
                               HStack {
                                   Text("Accept")
                                       .font(.title2)
                                       .foregroundColor(.white)
                                       .padding(.vertical, 20)
                               }
                               .frame(maxWidth: .infinity)
                                 .background(
                                   RoundedRectangle(cornerRadius: 20)
                                       .fill(Color(red: 0.153, green: 0.6, blue: 0.922))
                                       .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                               )
                               .cornerRadius(40)
                             }
 
                        }
                       .padding(.bottom, 70)

                   }
                }
                 
                
                if showingCalendar {
                    VStack {
                         HStack {
                            Button(action: { changeMonth(-1) }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.black)
                            }
                            
                            Text(monthYearString)
                                .font(.title2)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                            
                            Button(action: { changeMonth(1) }) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            ForEach(calendar.veryShortStandaloneWeekdaySymbols, id: \.self) { day in
                                Text(day)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.vertical, 10)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                            ForEach(daysInMonth, id: \.self) { date in
                                if let date = date {
                                    VStack {
                                        Text(dateFormatter.string(from: date))
                                            .foregroundColor(isWeekend(date) ? .red : .black)
                                        
                                        if let emotion = getEmotion(for: date) {
                                            Image(emotion.type.imageName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                    .frame(height: 40)
                                } else {
                                    Color.clear
                                        .frame(height: 40)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                Spacer()
            }
            .padding()
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
        .onAppear(perform: loadEmotions)
    }
    
    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    private var daysInMonth: [Date?] {
        guard let interval = calendar.dateInterval(of: .month, for: currentDate),
              let monthFirstWeekday = calendar.dateComponents([.weekday], from: interval.start).weekday else {
            return []
        }
        
        let offsetDays = monthFirstWeekday - calendar.firstWeekday
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentDate)?.count ?? 0
        
        var days: [Date?] = Array(repeating: nil, count: offsetDays)
        
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: interval.start) {
                days.append(date)
            }
        }
        
        while days.count % 7 != 0 {
            days.append(nil)
        }
        
        return days
    }
    
    private func isWeekend(_ date: Date) -> Bool {
        let weekday = calendar.component(.weekday, from: date)
        return weekday == 1 || weekday == 7
    }
    
    private func selectEmotion(_ emotion: EmotionType) {
        withAnimation {
            selectedEmotion = emotion
            showingEmotions = false
            saveEmotion(emotion)
        }
    }
    
    private func saveEmotion(_ emotion: EmotionType) {
        let newEmotion = Emotion(date: currentDate, type: emotion)
        savedEmotions.removeAll { calendar.isDate($0.date, inSameDayAs: currentDate) }
        savedEmotions.append(newEmotion)
        
        if let encoded = try? JSONEncoder().encode(savedEmotions) {
            UserDefaults.standard.set(encoded, forKey: "savedEmotions")
        }
    }
    
    private func loadEmotions() {
        if let data = UserDefaults.standard.data(forKey: "savedEmotions"),
           let decoded = try? JSONDecoder().decode([Emotion].self, from: data) {
            savedEmotions = decoded
        }
    }
    
    private func getEmotion(for date: Date) -> Emotion? {
        return savedEmotions.first { calendar.isDate($0.date, inSameDayAs: date) }
    }
    
    private func changeMonth(_ value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
            withAnimation {
                currentDate = newDate
            }
        }
    }
}
