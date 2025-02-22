import SwiftUI

struct GameView: View {
    @StateObject private var viewModel: GameViewModel
    @Binding var path: [String]
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(path: Binding<[String]>, region: String, countriesList: [Country]) {
        _path = path
        _viewModel = StateObject(wrappedValue: GameViewModel(region: region, countriesList: countriesList))
    }
    
    var body: some View {
        ZStack {
            VStack {
                progressView
                Spacer()
                questionView
                Spacer()
                answerView
            }
            .padding(30)
            .background(Color(#colorLiteral(red: 0.9715085625648499, green: 0.9715085625648499, blue: 0.9715085625648499, alpha: 1.0)))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
        }
        .padding(50)
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9443791509, green: 0.7896900177, blue: 0.9972682595, alpha: 1.0)), Color(#colorLiteral(red: 0.7936894298, green: 0.9429106116, blue: 0.9972818494, alpha: 1.0))]),
            startPoint: .topLeading, 
            endPoint: .bottomTrailing
        ))
    }
    
    private var progressView: some View {
        HStack {
            ProgressView(value: viewModel.progress)
                .padding(.trailing)
                .animation(.smooth, value: viewModel.progress)
            Text("✦  " + String(viewModel.points))
                .padding()
                .background(.blue.gradient)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: .blue.opacity(0.6), radius: 40, x: 0, y: 10)
                .animation(.easeInOut, value: viewModel.points)
        }
    }
    
    private var questionView: some View {
        HStack(spacing: 20) {
            Image("flag_" + viewModel.correctCountry.name)
                .resizable()
                .frame(maxWidth: 450, maxHeight: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 20)
                .animation(.easeInOut(duration: 1.0), value: viewModel.correctCountry.name)
            Spacer()
            CardView(maxLength: 300,
                     duration: 0.18,
                     type: "land",
                     content: "land_" + viewModel.correctCountry.name,
                     isHidden: viewModel.isHintHidden(.land))
            Spacer()
            CardView(maxLength: 300,
                     duration: 0.18,
                     type: "city",
                     content: viewModel.correctCountry.city, 
                     isHidden: viewModel.isHintHidden(.city))
        }
        .padding(.vertical, 20)
    }
    
    private var answerView: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.answerOptions) { country in
                    AnswerButton(
                        countryName: country.name.replacingOccurrences(of: "_", with: " "),
                        isCorrect: country.name == viewModel.correctCountry.name,
                        isWin: viewModel.isWin,
                        checkAnswer: { viewModel.checkAnswer(country.name) },
                        roundNum: viewModel.i
                    )
                    .disabled(viewModel.isWin != nil)
                }
            }
            
            if viewModel.i == viewModel.countriesList.count - 1 {
                NavigationLink(destination: FinishView(path: $path,
                                                       region: viewModel.region, 
                                                       countriesList: viewModel.countriesList,
                                                       results: viewModel.results, 
                                                       score: viewModel.points, 
                                                       total: viewModel.countriesList.count)) {
                    Text("Finish")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .opacity(viewModel.isWin == nil ? 0 : 1)
            } else {
                Button {
                    viewModel.nextQuestion()
                } label: {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .opacity(viewModel.isWin == nil ? 0 : 1)
            }
        }
    }
}
