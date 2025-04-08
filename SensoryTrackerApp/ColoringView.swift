//import SwiftUI
//import SwiftSVG
//
//struct ColoringView: View {
//    @State private var selectedColor: Color = .red
//    @State private var svgPaths: [SVGPath] = []
//    @State private var coloredPaths: [UUID: Color] = [:]
//    @State private var undoStack: [[UUID: Color]] = []
//    
//    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange, .pink, .brown]
//    
//    var body: some View {
//        VStack {
//            // Top toolbar
//            HStack {
//                Button(action: undo) {
//                    Image(systemName: "arrow.uturn.backward")
//                        .font(.title)
//                }
//                .disabled(undoStack.isEmpty)
//                
//                Spacer()
//                
//                Button(action: save) {
//                    Image(systemName: "square.and.arrow.down")
//                        .font(.title)
//                }
//            }
//            .padding()
//            
//            // SVG content
//            GeometryReader { geometry in
//                ZStack {
//                    // Background
//                    Color.white
//                    
//                    // SVG content
//                    if let svgView = SVGView(named: "coloring_image") {
//                        svgView
//                            .gesture(
//                                DragGesture(minimumDistance: 0)
//                                    .onEnded { value in
//                                        handleTap(at: value.location, in: geometry)
//                                    }
//                            )
//                    }
//                }
//            }
//            
//            // Color palette
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 20) {
//                    ForEach(colors, id: \.self) { color in
//                        Circle()
//                            .fill(color)
//                            .frame(width: 40, height: 40)
//                            .overlay(
//                                Circle()
//                                    .stroke(selectedColor == color ? Color.black : Color.clear, lineWidth: 3)
//                            )
//                            .onTapGesture {
//                                selectedColor = color
//                            }
//                    }
//                }
//                .padding()
//            }
//            .frame(height: 60)
//        }
//    }
//    
//    private func handleTap(at location: CGPoint, in geometry: GeometryProxy) {
//        // Here we'll implement the logic to determine which path was tapped
//        // and update its color
//        // This is a placeholder for the actual implementation
//    }
//    
//    private func undo() {
//        if !undoStack.isEmpty {
//            coloredPaths = undoStack.removeLast()
//        }
//    }
//    
//    private func save() {
//        // Here we'll implement the logic to save the colored image
//        // This is a placeholder for the actual implementation
//    }
//}
//
//struct SVGView: View {
//    let svgName: String
//    
//    init?(named svgName: String) {
//        self.svgName = svgName
//        // Here we'll implement the SVG loading logic
//        // This is a placeholder for the actual implementation
//    }
//    
//    var body: some View {
//        // Here we'll implement the SVG rendering
//        // This is a placeholder for the actual implementation
//        Text("SVG Content")
//    }
//}
//
//#Preview {
//    ColoringView()
//} 
