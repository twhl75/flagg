import SwiftUI

struct HomeView: View {
    @State private var path = [String]()
    
    private let columns = [GridItem(.flexible(), spacing: 30), GridItem(.flexible())]
    private let regionPathMap = getRegionPathMap(regions: regions)
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack {
                    HStack {
                        Text("Regions of Asia")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.black)
                        Spacer()
                        difficultyView
                    }
                    .padding(.bottom, 30)
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(regions) { region in
                            RegionCardView(name: region.name, place: region.place, color: region.color, difficulty: region.difficulty, path: $path)
                        }
                    }
                }
                .padding(50)
            }
            .navigationDestination(for: String.self) { regionName in
                GameView(path: $path, region: regionName, countriesList: regionPathMap[regionName]!.shuffled())
            }
            .scrollIndicators(.hidden)
            .background(LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 0.9398125609837246, blue: 0.9927547484723818, alpha: 1.0)), Color(#colorLiteral(red: 0.9999960065, green: 1.0, blue: 1.0, alpha: 1.0))]),
                startPoint: .top, 
                endPoint: .bottom
            ))
        }
    }
    
    private var difficultyView: some View {
        HStack {
            Text("Difficulty")
                .foregroundStyle(.blue)
                .padding(.trailing, 10)
            ForEach(0..<3, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow.gradient)
                    .shadow(radius: 20)
            }
        }
        .padding()
        .background(.blue.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .blue.opacity(0.6), radius: 40, x: 0, y: 10)
    }
}
