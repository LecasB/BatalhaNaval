import Foundation

var tabVis: [[String]] = Array(repeating: Array(repeating: "--", count: 11), count: 11)
var tabInvis: [[String]] = Array(repeating: Array(repeating: "--", count: 11), count: 11)

class Ship {
    var position: (row: Int, col: Int)
    var orientation: Orientation
    var size: Size
    
    enum Orientation {
        case horizontal
        case vertical
    }

    enum Size: Int {
        case aircraft = 5 
        case battleship = 4
        case cruiser = 3 
        case submarine = 2
        case destroyer = 1 
    }

    init(position: (row: Int, col: Int), orientation: Orientation, size: Size) {
        self.position = position
        self.orientation = orientation
        self.size = size
    }
    
    func placeShipOnBoard() {
        let row = position.row
        let col = position.col
        let size = self.size.rawValue
        
        switch orientation {
        case .horizontal:
            for i in 0..<size {
                tabVis[row - 1][col + i - 1] = "**"
            }
        case .vertical:
            for i in 0..<size {
                tabVis[row + i - 1][col - 1] = "**"
            }
        }
    }
}

func printGameBoard() {
    print("   ", terminator: "")
    for i in 0...11 {
        if (i==0){
            print("00 ",terminator: "")
        }
        else if (i == 10 || i == 11){
            print("\(i) ", terminator: "")
        }else{
            print("0\(i) ", terminator: "")
        }
    }

    print()

    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]
    for (index, row) in tabVis.enumerated() {
        
        print("\(letters[index])  ", terminator: "")
        
        for element in row {
            print(element, terminator: " ")
        }
        print()
    }
}

print("---Aircraft---")
print("Insira a cordernada x")
let linha = Int(readLine()!)!
print("Insira a cordenada y")
let coluna = Int(readLine()!)!
print("V - Vertical ou H - Horizontal? ")
var orienta = readLine()
var orientation: Ship.Orientation?
if let orienta = orienta {
    orientation = orienta.lowercased() == "v" ? .vertical : .horizontal
}
let aircraft = Ship(position: (Int(linha), Int(coluna)), orientation: orientation ?? .horizontal, size: .aircraft)
aircraft.placeShipOnBoard()

print("---Battleship---")
print("Insira a cordernada x")
let linha2 = Int(readLine()!)!
print("Insira a cordenada y")
let coluna2 = Int(readLine()!)!
print("V - Vertical ou H - Horizontal? ")
orienta = readLine()
if let orienta = orienta {
    orientation = orienta.lowercased() == "v" ? .vertical : .horizontal
}
let battleship = Ship(position: (Int(linha2), Int(coluna2)), orientation: orientation ?? .horizontal, size: .battleship)
battleship.placeShipOnBoard()

print("---Cruiser---")
print("Insira a cordernada x")
let linha3 = Int(readLine()!)!
print("Insira a cordenada y")
let coluna3 = Int(readLine()!)!
print("V - Vertical ou H - Horizontal? ")
orienta = readLine()
if let orienta = orienta {
    orientation = orienta.lowercased() == "v" ? .vertical : .horizontal
}
let cruiser = Ship(position: (Int(linha3), Int(coluna3)), orientation: orientation ?? .horizontal, size: .cruiser)
cruiser.placeShipOnBoard()

print("---Submarine---")
print("Insira a cordernada x")
let linha4 = Int(readLine()!)!
print("Insira a cordenada y")
let coluna4 = Int(readLine()!)!
print("V - Vertical ou H - Horizontal? ")
orienta = readLine()
if let orienta = orienta {
    orientation = orienta.lowercased() == "v" ? .vertical : .horizontal
}
let submarine = Ship(position: (Int(linha4), Int(coluna4)), orientation: orientation ?? .horizontal, size: .submarine)
submarine.placeShipOnBoard()

print("---Destroyer---")
print("Insira a cordernada x")
let linha5 = Int(readLine()!)!
print("Insira a cordenada y")
let coluna5 = Int(readLine()!)!
print("V - Vertical ou H - Horizontal? ")
orienta = readLine()
if let orienta = orienta {
    orientation = orienta.lowercased() == "v" ? .vertical : .horizontal
}
let destroyer = Ship(position: (Int(linha5), Int(coluna5)), orientation: orientation ?? .horizontal, size: .destroyer)
destroyer.placeShipOnBoard()

printGameBoard()
