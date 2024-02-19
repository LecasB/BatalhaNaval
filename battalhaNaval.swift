import Foundation

var tabVis: [[String]] = Array(repeating: Array(repeating: "--", count: 10), count: 10)
var tabInvis: [[String]] = Array(repeating: Array(repeating: "--", count: 10), count: 10)
var cont: Int = 0
class Ship {
    var position: (row: Int, col: Int)
    var orientation: Orientation
    var size: Size
    var isDestroyed: Bool = false
    var remainingHits: Int
    
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
        self.remainingHits = size.rawValue
    }
    
    func placeShipOnBoard() {
    let row = position.row
    let col = position.col
    let size = self.size.rawValue
    
    // Check if the ship fits within the game board
    if row < 1 || row > 10 || col < 1 || col > 10 {
        print("Ship position is out of bounds. Please enter a new position.")
        enterNewPosition()
        return
    }
    
    // Check if the ship overlaps with an existing ship
    switch orientation {
    case .horizontal:
        for i in 0..<size {
            if col + i - 1 >= 10 || tabVis[row - 1][col + i - 1] != "--" {
                print("Posicao Invalida. Insira Nova")
                enterNewPosition()
                return
            }
        }
    case .vertical:
        for i in 0..<size {
            if row + i - 1 >= 10 || tabVis[row + i - 1][col - 1] != "--" {
                print("Posicao Invalida. Insira Nova")
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
            remainingHits -= 1
        }
    case .vertical:
        for i in 0..<size {
            tabVis[row + i - 1][col - 1] = "**"
            remainingHits -= 1
        }
    }
    cont += 1
    if cont == 5 {
        printGameBoard()
        enviarBombas()
    }
}


func enviarBombas() {
    let shipsInOrder = [aircraft, battleship, cruiser, submarine, destroyer]
    
    while true {
        print("Insira a coordenada x para enviar uma bomba")
        guard let linha = Int(readLine()!), linha >= 1, linha <= 10 else {
            print("Coordenada inválida. Insira um número entre 1 e 10.")
            continue
        }
        
        print("Insira a coordenada y para enviar uma bomba")
        guard let coluna = Int(readLine()!), coluna >= 1, coluna <= 10 else {
            print("Coordenada inválida. Insira um número entre 1 e 10.")
            continue
        }
        
        if tabVis[linha - 1][coluna - 1] == "**" {
            print("Você acertou um navio!")
            tabVis[linha - 1][coluna - 1] = "XX"
        } else {
            print("Você não acertou nenhum navio.")
            tabVis[linha - 1][coluna - 1] = "~~"
        }
        
        // Print the updated game board
        printGameBoard()
        
        // Check if all ships have been destroyed
        if tabVis.flatMap({ $0 }).filter({ $0 == "**" }).isEmpty {
            print("Parabéns! Você destruiu todos os navios.")
            break
        }
        
        // Check if a ship is destroyed and print its name
        for ship in shipsInOrder {
            var isDestroyed = true
            for i in 0..<ship.size.rawValue {
                let row = ship.position.row
                let col = ship.position.col
                if ship.orientation == .horizontal {
                    if tabVis[row - 1][col + i - 1] != "XX" {
                        isDestroyed = false
                        break
                    }
                } else {
                    if tabVis[row + i - 1][col - 1] != "XX" {
                        isDestroyed = false
                        break
                    }
                }
            }
            if isDestroyed && !ship.isDestroyed {
                print("\(ship.size) foi destruído!")
                ship.isDestroyed = true
                break // Exit the loop after the first ship is destroyed
            }
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
    for i in 0...10 {
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
        guard let linha = Int(readLine()!), linha >= 1, linha <= 10 else {
            print("Coordenada inválida. Insira um número entre 1 e 10.")
            continue
        }
        
        print("Insira a coordenada y")
        guard let coluna = Int(readLine()!), coluna >= 1, coluna <= 10 else {
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

printGameBoard()

let aircraft = Ship(position: (0, 0), orientation: .horizontal, size: .aircraft)
enterShipPosition(ship: aircraft)
printGameBoard()

let battleship = Ship(position: (0, 0), orientation: .horizontal, size: .battleship)
enterShipPosition(ship: battleship)
printGameBoard()

let cruiser = Ship(position: (0, 0), orientation: .horizontal, size: .cruiser)
enterShipPosition(ship: cruiser)
printGameBoard()

let submarine = Ship(position: (0, 0), orientation: .horizontal, size: .submarine)
enterShipPosition(ship: submarine)
printGameBoard()

let destroyer = Ship(position: (0, 0), orientation: .horizontal, size: .destroyer)
enterShipPosition(ship: destroyer)
printGameBoard()

