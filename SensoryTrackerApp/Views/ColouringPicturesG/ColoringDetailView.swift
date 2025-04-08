//
//  ColoringDetailView.swift
//  SensoryTrackerApp
//
//  Created by Александра Тажибай on 07.04.2025.
//

import SwiftUI

struct ColoringDetailView: View {
    let card: ColoringCardModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedColor: Color = .purple
    @State private var showingAlert = false
    @State private var coloredAreas: [(path: Path, color: Color)] = []
    @State private var imageSize: CGSize = .zero
    @State private var currentPath: Path?
    private let brushSize: CGFloat = 15
    
    let colors: [[Color]] = [
        [.purple, .pink, .red, .orange, .yellow, .yellow.opacity(0.7), .yellow.opacity(0.4)],
        [.green.opacity(0.4), .green, .blue.opacity(0.3), .blue, .brown, .white, .black]
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Text("Back")
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                Button(action: {
                    saveImage()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
            
            // Title
            Text(card.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // Drawing Area
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .shadow(radius: 5)
                
                GeometryReader { geometry in
                    ZStack {
                        Image(card.imageName)
                            .resizable()
                            .scaledToFit()
                            .onAppear {
                                imageSize = geometry.size
                            }
                        
                        Canvas { context, size in
                            for (path, color) in coloredAreas {
                                context.fill(path, with: .color(color))
                            }
                            if let currentPath = currentPath {
                                context.fill(currentPath, with: .color(selectedColor))
                            }
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let touchPoint = value.location
                                    updatePath(at: touchPoint)
                                }
                                .onEnded { value in
                                    if let path = currentPath {
                                        coloredAreas.append((path: path, color: selectedColor))
                                        currentPath = nil
                                    }
                                }
                        )
                    }
                }
                .padding(20)
            }
            .padding(.horizontal)
            
            // Color Palette
            VStack(spacing: 15) {
                ForEach(colors, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { color in
                            ColorButton(color: color, isSelected: selectedColor == color) {
                                selectedColor = color
                            }
                        }
                    }
                }
            }
            .padding(.top)
            
            // Autoflower Button
            Button(action: {
                // Autoflower action
            }) {
                Text("Autoflower")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.blue.opacity(0.3))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 40)
            .padding(.top)
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
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
        .alert("Success", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Your coloring has been saved!")
        }
    }
    
    private func updatePath(at point: CGPoint) {
        if currentPath == nil {
            var path = Path()
            path.addEllipse(in: CGRect(x: point.x - brushSize/2, y: point.y - brushSize/2, width: brushSize, height: brushSize))
            currentPath = path
        } else {
            var path = currentPath!
            path.addEllipse(in: CGRect(x: point.x - brushSize/2, y: point.y - brushSize/2, width: brushSize, height: brushSize))
            currentPath = path
        }
    }
    
    private func saveImage() {
        let renderer = ImageRenderer(content:
            ZStack {
                Image(card.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize.width, height: imageSize.height)
                
                Canvas { context, size in
                    for (path, color) in coloredAreas {
                        context.fill(path, with: .color(color))
                    }
                    if let currentPath = currentPath {
                        context.fill(currentPath, with: .color(selectedColor))
                    }
                }
                .frame(width: imageSize.width, height: imageSize.height)
            }
        )
        
        renderer.scale = 2.0 // Увеличиваем качество изображения
        
        if let uiImage = renderer.uiImage {
            if let imageData = uiImage.pngData() {
                UserDefaults.standard.set(imageData, forKey: "colored_\(card.imageName)")
                showingAlert = true
            }
        }
    }
}

struct ColorButton: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 40, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: isSelected ? 3 : 0)
                )
        }
    }
}

//struct ColoringDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColoringDetailView(card: ColoringCardModel(title: "Animal", imageName: "color1"))
//    }
//}
