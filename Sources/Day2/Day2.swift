import Algorithms


public func partOne() {
    let inStrs = input.split(separator: "\n").map { $0.split(separator: " ") }
    var h = 0
    var d = 0
    for steer in inStrs {
        let delta = Int(steer.last!)!
        switch steer.first! {
        case "forward":
            h += delta
        case "back":
            h -= delta
        case "down":
            d += delta
        case "up":
            d -= delta
        default:
            print("error")
        }
    }
    print("h: \(h), d: \(d)")
    print(h*d)
}

public func partTwo() {
    let inStrs = input.split(separator: "\n").map { $0.split(separator: " ") }
    var h = 0
    var d = 0
    var aim = 0
    for steer in inStrs {
        let delta = Int(steer.last!)!
        switch steer.first! {
        case "forward":
            h += delta
            d += aim * delta
        case "back":
            h -= delta
            d -= aim * delta
        case "down":
            aim += delta
        case "up":
            aim -= delta
        default:
            print("error")
        }
        
    }
    print("h: \(h), d: \(d)")
    print(h*d)
}
