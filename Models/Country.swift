import SwiftUI

struct Country: Identifiable {
    let name: String
    let city: String
    var id:   String { name }
}

struct Region: Identifiable {
    let name: String
    let place: String
    let color: Color
    let countries: [Country]
    let difficulty: Int
    var id: String { name }
}

var countriesCentralAsia: [Country] = [
    Country(name: "Kazakhstan", city: "Astana"),
    Country(name: "Kyrgyzstan", city: "Bishkek"),
    Country(name: "Tajikistan", city: "Dushanbe"),
    Country(name: "Turkmenistan", city: "Ashgabat"),
    Country(name: "Uzbekistan", city: "Tashkent")
]

var countriesEastAsia: [Country] = [
    Country(name: "China", city: "Beijing"),
    Country(name: "Hong_Kong", city: "Hong Kong"),
    Country(name: "Japan", city: "Tokyo"),
    Country(name: "Macao", city: "Macao"),
    Country(name: "Mongolia", city: "Ulaanbaatar"),
    Country(name: "North_Korea", city: "Pyongyang"),
    Country(name: "South_Korea", city: "Seoul"),
    Country(name: "Taiwan", city: "Taipei")
]

var countriesSouthAsia: [Country] = [
    Country(name: "Afghanistan", city: "Kabul"),
    Country(name: "Bangladesh", city: "Dhaka"),
    Country(name: "Bhutan", city: "Thimphu"),
    Country(name: "India", city: "New Delhi"),
    Country(name: "Maldives", city: "Malé"),
    Country(name: "Nepal", city: "Kathmandu"),
    Country(name: "Pakistan", city: "Islamabad"),
    Country(name: "Sri_Lanka", city: "Colombo")
]

var countriesSoutheastAsia: [Country] = [
    Country(name: "Brunei", city: "Bandar Seri Begawan"),
    Country(name: "Cambodia", city: "Phnom Penh"),
    Country(name: "Indonesia", city: "Jakarta"),
    Country(name: "Laos", city: "Vientiane"),
    Country(name: "Malaysia", city: "Kuala Lumpur"),
    Country(name: "Myanmar", city: "Naypyidaw"),
    Country(name: "Philippines", city: "Manila"),
    Country(name: "Singapore", city: "Singapore"),
    Country(name: "Thailand", city: "Bangkok"),
    Country(name: "Timor-Leste", city: "Dili"),
    Country(name: "Vietnam", city: "Hanoi")
]

var countriesWestAsia: [Country] = [
    Country(name: "Bahrain", city: "Manama"),
    Country(name: "Iran", city: "Tehran"),
    Country(name: "Iraq", city: "Baghdad"),
    Country(name: "Israel", city: "Jerusalem"),
    Country(name: "Jordan", city: "Amman"),
    Country(name: "Kuwait", city: "Kuwait City"),
    Country(name: "Lebanon", city: "Beirut"),
    Country(name: "Oman", city: "Muscat"),
    Country(name: "Qatar", city: "Doha"),
    Country(name: "Saudi_Arabia", city: "Riyadh"),
    Country(name: "Syria", city: "Damascus"),
    Country(name: "Turkey", city: "Istanbul"),
    Country(name: "United_Arab_Emirates", city: "Abu Dhabi"),
    Country(name: "Yemen", city: "Sanaa")
]

var regions: [Region] = [
    Region(name: "Central Asia", place: "Registan Square", color: Color(#colorLiteral(red: 0.0, green: 0.2136589885, blue: 0.2883136272, alpha: 1.0)), countries: countriesCentralAsia, difficulty: 1),
    Region(name: "East Asia", place: "Forbidden City", color: Color(#colorLiteral(red: 0.06642952561, green: 0.01990295202, blue: 0.2326065004, alpha: 1.0)), countries: countriesEastAsia, difficulty: 2),
    Region(name: "South Asia", place: "Taj Mahal", color: Color(#colorLiteral(red: 0.1481023431, green: 0.2412780225, blue: 0.0572719276, alpha: 1.0)), countries: countriesSouthAsia, difficulty: 2),
    Region(name: "Southeast Asia", place: "Angkor Wat", color: Color(#colorLiteral(red: 0.353153944, green: 0.1100037917, blue: 0.0, alpha: 1.0)), countries: countriesSoutheastAsia, difficulty: 3),
    Region(name: "West Asia", place: "Al Jahili Fort", color: Color(#colorLiteral(red: 0.5123859048, green: 0.0651082322, blue: 0.0, alpha: 1.0)), countries: countriesWestAsia, difficulty: 4)
]

func getRandomCountries(countries: [Country], n: Int, correctAnswer: Country) -> [Country] {
    guard n > 0 else { return [] }
    
    var answers = countries.filter { $0.name != correctAnswer.name }.shuffled()
    answers = Array(answers.prefix(n - 1))
    answers.append(correctAnswer)
    
    return answers.shuffled()
}

func getRegionPathMap(regions: [Region]) -> [String: [Country]] {
    var regionPathMap = [String: [Country]]()
    
    for region in regions {
        regionPathMap[region.name] = region.countries
    }
    
    return regionPathMap
}
