import SwiftUI

struct TabContentView: View {
    let index: Int

    var body: some View {
        VStack(spacing: 20) {
            Text("Основной экран \(index + 1)")
                .font(.title)
                .bold()
            Text("Контент для вкладки \(index + 1)")
        }
    }
}