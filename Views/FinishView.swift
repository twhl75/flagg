import SwiftUI

struct FinishView: View {
    @Binding var path: [String]
    
    let region: String
    let countriesList: [Country]
    let results: [String: Bool]
    let score: Int
    let total: Int
    
    private let columns = [GridItem(.flexible()), 
                           GridItem(.flexible()), 
                           GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    congratsView
                        .padding(.trailing, 30)
                    Spacer()
                    scoreView
                }
                .padding(.bottom, 40)
                Spacer()
                resultsView
                backButtonView
                Spacer()
            }
            .padding(.vertical, 50)
            .padding(.horizontal, 80)
        }
        .scrollIndicators(.hidden)
        .navigationBarHidden(true)
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 0.9398125609837246, blue: 0.9927547484723818, alpha: 1.0)), Color(#colorLiteral(red: 0.9999960065, green: 1.0, blue: 1.0, alpha: 1.0))]),
            startPoint: .top, 
            endPoint: .bottom
        ))
    }
    
    private var congratsView: some View {
        VStack {
            Text("Congratulations! 🎉")
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundStyle(.black)
            Text("You've completed the countries of " + region)
                .foregroundStyle(.black)
        }
        .foregroundStyle(.white)
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 20, x: 0, y: 10)
    }
    
    private var scoreView: some View {
        Text("SCORE: " + String(score) + " / " + String(total))
            .font(.title)
            .bold()
            .foregroundStyle(.white)
            .frame(width: 300, height: 150)
            .padding()
            .background(.blue.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .blue.opacity(0.6), radius: 20, x: 0, y: 10)
    }
    
    private var resultsView: some View {
        LazyVGrid(columns: columns) {
            ForEach(Array(results.keys).sorted(by: <), id: \.self) { key in
                VStack {
                    Image("flag_" + key)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: results[key] == true ? .green : .red, radius: 20, x: 0, y: 10)
                    Text(key.replacingOccurrences(of: "_", with: " "))
                        .foregroundStyle(.black)
                        .padding(.bottom)
                }
                .backgroundStyle(.red)
            }
        }
        .padding(.vertical, 30)
    }
    
    private var backButtonView: some View {
        Button {
            path.removeAll()
        } label: {
            Text("Back Home")
                .frame(width: 200)
                .padding()
                .background(.green)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
