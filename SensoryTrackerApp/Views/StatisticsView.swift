import SwiftUI
import Charts

struct StatisticsView: View {
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var isDaily = true
    @State private var dailyData: [StatData] = [
        StatData(time: "9:00", value: 0.5),
        StatData(time: "12:00", value: 1.2),
        StatData(time: "15:00", value: 0.8),
        StatData(time: "18:00", value: 2.0),
        StatData(time: "21:00", value: 0.3),
        StatData(time: "00:00", value: 0.4),
        StatData(time: "03:00", value: 0.2)
    ]
    
    @State private var weeklyData: [StatData] = [
        StatData(time: "Mon", value: 0.5),
        StatData(time: "Tue", value: 3.5),
        StatData(time: "Wen", value: 0.8),
        StatData(time: "Tue", value: 9.5),
        StatData(time: "Fri", value: 0.3),
        StatData(time: "Sat", value: 3.8),
        StatData(time: "Sun", value: 1.5)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Statistic")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Show Back button only in fullscreen mode
            if presentationMode.wrappedValue.isPresented {
                HStack {
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Text("Back")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 24)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(red: 0.153, green: 0.6, blue: 0.922))
                            )
                    }
                    Spacer()
                }
            }
            
            HStack {
                Button(action: {
                    withAnimation {
                        isDaily = true
                    }
                }) {
                    Text("Daily")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 24)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(isDaily ? Color(red: 0.153, green: 0.6, blue: 0.922) : Color.black.opacity(0.3))
                        )
                }
                
                Button(action: {
                    withAnimation {
                        isDaily = false
                    }
                }) {
                    Text("Weekly")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 24)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(!isDaily ? Color(red: 0.153, green: 0.6, blue: 0.922) : Color.black.opacity(0.3))
                        )
                }
            }
            
            Text("Total: \(calculateTotal())")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Chart
            Chart {
                ForEach(isDaily ? dailyData : weeklyData) { item in
                    BarMark(
                        x: .value("Time", item.time),
                        y: .value("Value", item.value)
                    )
                    .foregroundStyle(Color(red: 0.153, green: 0.6, blue: 0.922).opacity(0.7))
                    .cornerRadius(8)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                        .foregroundStyle(Color.white.opacity(0.3))
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .chartXAxis {
                AxisMarks { value in
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .frame(height: 300)
            .padding()
            
            Spacer()
        }
        .padding()
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
    }
    
    private func calculateTotal() -> Int {
        let data = isDaily ? dailyData : weeklyData
        return Int(data.reduce(0) { $0 + $1.value })
    }
}

struct StatData: Identifiable {
    let id = UUID()
    let time: String
    let value: Double
}

// Preview with default binding
extension Binding where Value == Bool {
    static func mock() -> Self {
        .constant(true)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(isPresented: .mock())
    }
}
