import SwiftUI

struct AnswerButton: View {
    let countryName: String
    let isCorrect: Bool
    let isWin: Bool?
    let checkAnswer: () -> Void
    let roundNum: Int
    
    @State var isSelected = false
    
    var body: some View {
        Button {
            isSelected = true
            checkAnswer()
        } label: {
            Text(countryName)
                .frame(maxWidth: .infinity)
                .padding()
                .background(buttonColor().opacity(0.3))
                .foregroundStyle(buttonColor())
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .onChange(of: roundNum, {_, _ in
            isSelected = false
        })
    }
    
    func buttonColor() -> Color {
        if isSelected || isWin == false {
            return isCorrect ? .green : .red
        } else {
            return Color(#colorLiteral(red: 0.4795339107513428, green: 0.4795339107513428, blue: 0.4795339107513428, alpha: 1.0))
        }
    }
}
