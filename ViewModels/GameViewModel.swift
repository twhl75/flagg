import SwiftUI

final class GameViewModel: ObservableObject {
    @Published var correctCountry: Country
    @Published var answerOptions: [Country]
    @Published var isWin: Bool?
    @Published var wrongAttempts = 0
    @Published var revealedHints: Set<Hint> = [Hint.flag]
    @Published var points = 0
    @Published var i = 0
    @Published var progress = 0.0
    @Published var results: [String: Bool] = [:]
    
    let region: String
    let countriesList: [Country]
    
    enum Hint {
        case flag, land, city
    }
    
    init (region: String, countriesList: [Country]) {
        self.region = region
        self.countriesList = countriesList
        
        correctCountry = countriesList[0]
        answerOptions = getRandomCountries(countries: countriesList, n: min(6, countriesList.count), correctAnswer: countriesList[0])
    }
    
    func checkAnswer(_ selectedCountry: String) {
        if selectedCountry == correctCountry.name {
            isWin = true
            points += 1
            results[correctCountry.name] = true
        } else {
            wrongAttempts += 1

            switch wrongAttempts {
            case 1:
                revealedHints.insert(Hint.land)
            case 2:
                revealedHints.insert(Hint.city)
            default:
                isWin = false
                results[correctCountry.name] = false
            }
        }
    }
    
    func isHintHidden(_ hint: Hint) -> Bool {
        !revealedHints.contains(hint) && (isWin == nil)
    }
    
    func revealHint(_ hint: Hint) {
        revealedHints.insert(hint)
    }
    
    func nextQuestion() {
        if i == countriesList.count - 1 {
            return
        } else {
            i += 1
            progress = Double(i + 1) / Double(countriesList.count)
            resetRound()
        }
    }
    
    func resetRound() {
        correctCountry = countriesList[i]
        answerOptions = getRandomCountries(countries: countriesList, n: min(6, countriesList.count), correctAnswer: countriesList[i])
        isWin = nil
        wrongAttempts = 0
        revealedHints.remove(Hint.land)
        revealedHints.remove(Hint.city)
    }
}
