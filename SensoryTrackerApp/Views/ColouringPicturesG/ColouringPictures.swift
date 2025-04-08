//
//  ColouringPicturesView.swift
//  SensoryTrackerApp
//
//  Created by Александра Тажибай on 07.04.2025.
//

//import SwiftUI
//
//struct ColouringPictures: View {
//    var body: some View {
//        VStack {
//            Text("Colouring Pictures")
//                .font(.largeTitle)
//                .bold()
//            Text("This screen is for colouring activities.")
//        }
//        .padding()
//    }
//}
import SwiftUI
enum ColoringCategory {
    case animals
    case nature
    case figure
}
struct TherapeuticColoringView: View {
    @Binding var isTabBarVisible: Bool
    @State private var savedWorks: [String: UIImage] = [:]
    @State private var selectedCategory: ColoringCategory = .animals
    
    let cards = [
        ColoringCardModel(imageName: "color1", title: "Windmill"),
        ColoringCardModel(imageName: "color2", title: "Grid Pattern"),
        ColoringCardModel(imageName: "color3", title: "Nature 1"),
        ColoringCardModel(imageName: "color4", title: "Zebra"),
        ColoringCardModel(imageName: "color5", title: "Tiger"),
        ColoringCardModel(imageName: "color6", title: "Dino"),
        ColoringCardModel(imageName: "color7", title: "Maugli"),
        ColoringCardModel(imageName: "color8", title: "Dep"),
        ColoringCardModel(imageName: "color9", title: "Cazik"),
    ]
    let cardsFigure = [
        ColoringCardModel(imageName: "color11", title: "Windmill"),
        ColoringCardModel(imageName: "color21", title: "Grid Pattern"),
        ColoringCardModel(imageName: "color31", title: "Nature 1"),
        ColoringCardModel(imageName: "color41", title: "Zebra"),
        ColoringCardModel(imageName: "color51", title: "Tiger"),
        ColoringCardModel(imageName: "color61", title: "Dino")
    ]
    let cardsNature = [
        ColoringCardModel(imageName: "color12", title: "Windmill"),
        ColoringCardModel(imageName: "color22", title: "Grid Pattern"),
        ColoringCardModel(imageName: "color32", title: "Nature 1"),
        ColoringCardModel(imageName: "color42", title: "Zebra"),
        
    ]
    var currentCards: [ColoringCardModel] {
        switch selectedCategory {
        case .animals:
            return cards
        case .nature:
            return cardsNature
        case .figure:
            return cardsFigure
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Therapeutic\ncoloring pages")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                // Сегментированный контроль
                HStack(spacing: 10) {
                    CategoryButton(title: "Animals", isSelected: selectedCategory == .animals) {
                        withAnimation {
                            selectedCategory = .animals
                        }
                    }
                    
                    CategoryButton(title: "Nature", isSelected: selectedCategory == .nature) {
                        withAnimation {
                            selectedCategory = .nature
                        }
                    }
                    
                    CategoryButton(title: "Figure", isSelected: selectedCategory == .figure) {
                        withAnimation {
                            selectedCategory = .figure
                        }
                    }
                }
                .padding(.horizontal)
 
                // Сетка карточек
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(currentCards) { card in
                            NavigationLink(destination: 
                                ColoringDetailView(card: card)
                                    .onAppear { isTabBarVisible = false }
                                    .onDisappear { 
                                        isTabBarVisible = true
                                        loadSavedWorks()
                                    }
                            ) {
                                ColoringCardView(card: card, savedImage: savedWorks["colored_\(card.imageName)"])
                            }
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 60)
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
            .onAppear {
                loadSavedWorks()
            }
        }
    }
    
    private func loadSavedWorks() {
        for card in currentCards {
            if let imageData = UserDefaults.standard.data(forKey: "colored_\(card.imageName)"),
               let uiImage = UIImage(data: imageData) {
                savedWorks["colored_\(card.imageName)"] = uiImage
            }
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.black.opacity(0.3) : Color(red: 108/255, green: 206/255, blue: 255/255))
                )
            
        }
    }
}

struct ColoringCardView: View {
    let card: ColoringCardModel
    let savedImage: UIImage?
    
    var body: some View {
        VStack {
            if let savedImage = savedImage {
                Image(uiImage: savedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            } else {
                Image(card.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            }
 
            Button(action: {}) {
                Text("Start")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color(red: 108/255, green: 206/255, blue: 255/255))
                    .cornerRadius(20)
            }
            .padding(.top, 8)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 108/255, green: 206/255, blue: 255/255), lineWidth: 1)
        )
    }
}

struct TherapeuticColoringView_Previews: PreviewProvider {
    static var previews: some View {
        TherapeuticColoringView(isTabBarVisible: .constant(true))
    }
}
