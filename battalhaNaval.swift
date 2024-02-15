var tabVis: [[String]] = Array(repeating: Array(repeating: "--", count: 11), count: 11)
var tabInvis: [[String]] = Array(repeating: Array(repeating: "--", count: 11), count: 11)

struct Ship {
    var position: (row: Int, col: Int)
    var orientation: Orientation
    var size: Size
    
    enum Orientation {
        case horizontal
        case vertical
    }

    enum Size {
        case aircraft 
        case battleship 
        case cruiser 
        case submarine 
        case destroyer 
    }
}

// Print the first horizontal line with numbers
print("   ", terminator: "")
for i in 0...11 {
    if (i==0){
        print(" 🚢 ",terminator: "")
    }
    else if (i == 10 || i == 11){
    print("\(i) ", terminator: "")
    }else{
    print("0\(i) ", terminator: "")
    }
}

print()

// Print the remaining rows
let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]
for (index, row) in tabVis.enumerated() {
    // Print the first vertical line with letters
    print("\(letters[index])  ", terminator: "")
    
    // Print the elements of the row
    for element in row {
        print("\(element) ", terminator: "")
    }
    print()
}
