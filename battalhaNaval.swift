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
    
    // Check if the ship fits within the game board
    if row < 1 || row > 11 || col < 1 || col > 11 {
        print("Ship position is out of bounds. Please enter a new position.")
        return
    }
    
    // Check if the ship overlaps with an existing ship
    switch orientation {
    case .horizontal:
        for i in 0..<size {
            if tabVis[row - 1][col + i - 1] != "--" {
                print("Ship position overlaps with another ship. Please enter a new position.")
                enterNewPosition()
                return
            }
        }
    case .vertical:
        for i in 0..<size {
            if tabVis[row + i - 1][col - 1] != "--" {
                print("Ship position overlaps with another ship. Please enter a new position.")
                enterNewPosition()
                return
            }
        }
    }
    
    // Place the ship on the board
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

func enterNewPosition() {
    print("Insira a cordenada x")
    guard let linha = Int(readLine()!) else {
        print("Coordenada inválida. Insira um número entre 1 e 10.")
        enterNewPosition()
        return
    }
    
    print("Insira a cordenada y")
    guard let coluna = Int(readLine()!) else {
        print("Coordenada inválida. Insira um número entre 1 e 10.")
        enterNewPosition()
        return
    }
    
    print("V - Vertical ou H - Horizontal? ")
    guard let orienta = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !orienta.isEmpty, (orienta.lowercased() == "v" || orienta.lowercased() == "h") else {
        print("Orientação inválida. Insira 'V' para vertical ou 'H' para horizontal.")
        enterNewPosition()
        return
    }
    
    let orientation: Ship.Orientation = orienta.lowercased() == "v" ? .vertical : .horizontal
    position = (linha, coluna)
    self.orientation = orientation
    
    // Check if the new ship's position overlaps with an existing ship
    placeShipOnBoard()
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

func enterShipPosition(ship: Ship) {
print("---\(ship.size)---")
    while true {
       
        
        print("Insira a coordenada x")
        guard let linha = Int(readLine()!), linha >= 1, linha <= 11 else {
            print("Coordenada inválida. Insira um número entre 1 e 10.")
            continue
        }
        
        print("Insira a coordenada y")
        guard let coluna = Int(readLine()!), coluna >= 1, coluna <= 11 else {
            print("Coordenada inválida. Insira um número entre 1 e 10.")
            continue
        }
        
        print("V - Vertical ou H - Horizontal? ")
        guard let orienta = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !orienta.isEmpty, (orienta.lowercased() == "v" || orienta.lowercased() == "h") else {
            print("Orientação inválida. Insira 'V' para vertical ou 'H' para horizontal.")
            continue
        }
        
        let orientation: Ship.Orientation = orienta.lowercased() == "v" ? .vertical : .horizontal
        ship.position = (linha, coluna)
        ship.orientation = orientation
        ship.placeShipOnBoard()
        
        // If the ship has been successfully placed on the board, break out of the loop
        break
    }
}



let aircraft = Ship(position: (0, 0), orientation: .horizontal, size: .aircraft)
enterShipPosition(ship: aircraft)


let battleship = Ship(position: (0, 0), orientation: .horizontal, size: .battleship)
enterShipPosition(ship: battleship)


let cruiser = Ship(position: (0, 0), orientation: .horizontal, size: .cruiser)
enterShipPosition(ship: cruiser)


let submarine = Ship(position: (0, 0), orientation: .horizontal, size: .submarine)
enterShipPosition(ship: submarine)


let destroyer = Ship(position: (0, 0), orientation: .horizontal, size: .destroyer)
enterShipPosition(ship: destroyer)

printGameBoard()