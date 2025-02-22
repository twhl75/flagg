import SwiftUI

struct RegionCardView: View {
    @State private var isPressed = false
    
    let name: String
    let place: String
    let color: Color
    let difficulty: Int
    
    @Binding var path: [String]
    
    var body: some View {
        ZStack {
            Image(place)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 550)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(radius: 20, x: 0, y: 10)
            
            VStack {
                Spacer()
                HStack {
                    Image(name)
                        .resizable()
                        .frame(width: 75, height: 75)
                        .shadow(radius: 10)
                    Text(name)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .shadow(radius: 20)
                    Spacer()
                    ForEach(0..<difficulty, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow.gradient)
                            .shadow(radius: 20)
                    }
                }
                .padding(25)
                .frame(maxWidth: 550)
                .background(
                    Rectangle()
                        .fill(LinearGradient(colors: [Color.clear, color.opacity(0.8)], 
                                             startPoint: .top, 
                                             endPoint: .bottom))
                        .mask(RoundedRectangle(cornerRadius: 14, style: .continuous))
                )
            }
        }
        .scaleEffect(isPressed ? 0.9 : 1.0)
        .animation(.spring(), value: isPressed)
        .onTapGesture {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    path.append(name)
                }
            }
        }
    }
}
