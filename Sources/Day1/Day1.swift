import Algorithms

public func partOne() {
    let inInts = input.split(separator: "\n").compactMap { Int($0) }
    var count = 0
    for pair in inInts.windows(ofCount: 2) {
        let res = pair.first! < pair.last! ? "i" : "d"
        if res == "i" { count += 1}
    }
    print(count)
}

public func partTwo() {
    let inInts = input.split(separator: "\n").compactMap { Int($0) }
    var sums = [Int]()
    for triple in inInts.windows(ofCount: 3) {
        sums.append(triple.reduce(0, +))
    }
    var count = 0
    for pair in sums.windows(ofCount: 2) {
        let res = pair.first! < pair.last! ? "i" : "d"
        if res == "i" { count += 1 }
    }
    print(count)
}
