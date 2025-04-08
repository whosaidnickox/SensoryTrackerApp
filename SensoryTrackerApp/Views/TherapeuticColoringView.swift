//import SwiftUI
//
//enum ColoringCategory {
//    case animals
//    case nature
//    case figure
//}
//
//struct TherapeuticColoringView: View {
//    @State private var selectedCategory: ColoringCategory = .animals
//    
//    let cards = [
//        ColoringCardModel(title: "Windmill", imageName: "color1"),
//        ColoringCardModel(title: "Grid Pattern", imageName: "color2"),
//        ColoringCardModel(title: "Nature 1", imageName: "color3"),
//        ColoringCardModel(title: "Zebra", imageName: "color4"),
//        ColoringCardModel(title: "Tiger", imageName: "color5"),
//        ColoringCardModel(title: "Dino", imageName: "color6")
//    ]
//    
//    let cardsFigure = [
//        ColoringCardModel(title: "Figure 1", imageName: "figure1"),
//        ColoringCardModel(title: "Figure 2", imageName: "figure2"),
//        ColoringCardModel(title: "Figure 3", imageName: "figure3")
//    ]
//    
//    let cardsNature = [
//        ColoringCardModel(title: "Nature 1", imageName: "nature1"),
//        ColoringCardModel(title: "Nature 2", imageName: "nature2"),
//        ColoringCardModel(title: "Nature 3", imageName: "nature3")
//    ]
//    
//    var currentCards: [ColoringCardModel] {
//        switch selectedCategory {
//        case .animals:
//            return cards
//        case .nature:
//            return cardsNature
//        case .figure:
//            return cardsFigure
//        }
//    }
    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Text("Therapeutic\ncoloring pages")
//                    .font(.system(size: 36, weight: .bold))
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                    .padding(.top, 20)
//                
//                // Сегментированный контроль
//                HStack(spacing: 10) {
//                    CategoryButton(title: "Animals", isSelected: selectedCategory == .animals) {
//                        withAnimation {
//                            selectedCategory = .animals
//                        }
//                    }
//                    
//                    CategoryButton(title: "Nature", isSelected: selectedCategory == .nature) {
//                        withAnimation {
//                            selectedCategory = .nature
//                        }
//                    }
//                    
//                    CategoryButton(title: "Figure", isSelected: selectedCategory == .figure) {
//                        withAnimation {
//                            selectedCategory = .figure
//                        }
//                    }
//                }
//                .padding(.horizontal)
//                
//                // Сетка карточек
//                ScrollView {
//                    LazyVGrid(columns: [
//                        GridItem(.flexible(), spacing: 16),
//                        GridItem(.flexible(), spacing: 16)
//                    ], spacing: 16) {
//                        ForEach(currentCards) { card in
//                            NavigationLink(destination: ColoringDetailView(card: card)) {
//                                ColoringCardView(card: card)
//                            }
//                        }
//                    }
//                    .padding()
//                }
//            }
//            .background(
//                LinearGradient(
//                    gradient: Gradient(colors: [
//                        Color(red: 13/255, green: 184/255, blue: 254/255),
//                        Color(red: 0/255, green: 25/255, blue: 125/255)
//                    ]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//                .ignoresSafeArea()
//            )
//        }
//    }
//}
//
//struct CategoryButton: View {
//    let title: String
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            Text(title)
//                .font(.system(size: 16, weight: .medium))
//                .foregroundColor(.white)
//                .padding(.vertical, 8)
//                .padding(.horizontal, 16)
//                .background(
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(isSelected ? Color.black.opacity(0.3) : Color(red: 108/255, green: 206/255, blue: 255/255))
//                )
//        }
//    }
//}
//
//struct ColoringCardView: View {
//    let card: ColoringCardModel
//    
//    var body: some View {
//        VStack {
//            Image(card.imageName)
//                .resizable()
//                .scaledToFit()
//                .frame(height: 150)
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(Color(red: 108/255, green: 206/255, blue: 255/255), lineWidth: 1)
//                )
//            
//            Button(action: {}) {
//                Text("Start")
//                    .font(.system(size: 16, weight: .medium))
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 8)
//                    .background(Color(red: 108/255, green: 206/255, blue: 255/255))
//                    .cornerRadius(20)
//            }
//            .padding(.top, 8)
//        }
//        .padding(12)
//        .background(Color.white.opacity(0.1))
//        .cornerRadius(16)
//        .overlay(
//            RoundedRectangle(cornerRadius: 16)
//                .stroke(Color(red: 108/255, green: 206/255, blue: 255/255), lineWidth: 1)
//        )
//    }
//}
//
//struct TherapeuticColoringView_Previews: PreviewProvider {
//    static var previews: some View {
//        TherapeuticColoringView()
//    }
//} 
