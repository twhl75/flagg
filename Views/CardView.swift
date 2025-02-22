import SwiftUI

struct CardFront : View {
    let maxLength : CGFloat
    let type: String
    let content : String
    
    @Binding var degree : Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white.gradient)
                .frame(maxWidth: maxLength, maxHeight: maxLength)
                .shadow(radius: 20, x: 0, y: 10)
            
            if type == "land" {
                Image(content)
                    .resizable()
                    .frame(maxWidth: 220, maxHeight: 220)
                    .padding()
            } else if type == "city" {
                Text(content)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack : View {
    let maxLength : CGFloat
    let type: String
    
    @Binding var degree : Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.pink.gradient)
                .frame(maxWidth: maxLength, maxHeight: maxLength)
                .shadow(color: .pink.opacity(0.6), radius: 20, x: 0, y: 10)
            
            VStack {
                if type == "land" {
                    Text("hint 1")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                    Text("land")
                        .foregroundStyle(.white)
                } else if type == "city" {
                    Text("hint 2")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                    Text("capital city")
                        .foregroundStyle(.white)
                }
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardView: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let maxLength : Double
    let duration : Double
    let type: String
    let content : String
    let isHidden : Bool

    var body: some View {
        ZStack {
            CardFront(maxLength: maxLength, 
                      type: type, 
                      content: content, 
                      degree: $frontDegree)
            CardBack(maxLength: maxLength, 
                     type: type,
                     degree: $backDegree)
        }.onChange(of: isHidden, { _, _ in
            flip()
        })
    }
    
    func flip() {
        isFlipped = !isFlipped
        
        if isFlipped {
            withAnimation(.linear(duration: duration)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: duration).delay(duration)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: duration)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: duration).delay(duration)){
                backDegree = 0
            }
        }
    }
}
