var tabVis: [[String]] = Array(repeating: Array(repeating: "--", count: 11), count: 11)
var tabInvis: [[String]] = Array(repeating: Array(repeating: "--", count: 11), count: 11)


for row in tabVis {
    for element in row {
        print("\(element) ", terminator: "")
    }
    print()
}