import SwiftUI

struct OnboardingPage: View {
    let index: Int
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var title: String {
        "Your daily assistant for a calm and structured life"
    }

    var subtitle: String {
        switch index {
        case 0: return "Colouring pictures"
        case 1: return "Centre assistant"
        case 2: return "Daily routine"
        case 3: return "Emotion tracker"
        default: return ""
        }
    }

    var images: [String] {
        switch index {
        case 0:
            return ["Colouring"]
        case 1:
            return ["Message"]
        case 2:
            return ["Light"]
        case 3:
            return ["Angry"]
        default:
            return []
        }
    }
    
    var baseImageSize: CGFloat {
        horizontalSizeClass == .regular ? 200 : 100
    }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text(title)
                .font(.largeTitle)
                .lineLimit(2) // Максимум 2 строки
                .minimumScaleFactor(0.35)
                .foregroundStyle(Color.white)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

//            if index == 0 {
                Image(images.first ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: baseImageSize * 3, height: baseImageSize * 3)
                    .foregroundColor(.white)
                    .padding()
//            } else {
//                VStack(spacing: 4) { // минимальный отступ между изображениями
//                    ForEach(images, id: \.self) { imageName in
//                        HStack{
//                            Image(imageName)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: imageFrameSize)
//                                .foregroundColor(.white)
//                        }
//                        
//                    }
//                }
//                .padding(.horizontal)
//            }

            Text(subtitle)
                .font(.largeTitle)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .padding()
    }
    
    private var imageFrameSize: CGFloat {
        switch index {
        case 1, 2:
            return baseImageSize  // поменьше
        case 3:
            return baseImageSize       // стандартный размер
        default:
            return baseImageSize
        }
    }
}
