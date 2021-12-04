import Algorithms

public func partOne() {
    let uInts = linesToStrings(input).map { UInt16($0, radix: 2)! }
    print(uInts.first!)
    // bitwise manipulation
    let bitCounts = sumRowBits(uInts, bitWidth: 12).map { Double($0) }
    print(bitCounts)
    print(uInts.count)
    
    let bits = toBits(bitCounts, pointCount: uInts.count, bitWidth: 12)
    print(bits)
        
    let gamma = toUInt16(bits)
    print(String(gamma, radix:2))
    print("====")
    print(gamma)
    let eps = ~gamma & 0b0000111111111111
    print(String(eps, radix: 2))
    print(eps)
    print(UInt32(eps))
    print(UInt32(eps)*UInt32(gamma))
}

private func sumRowBits(_ input: [UInt16], bitWidth: Int) -> [Int] {
    var bitCounts = Array(repeating: 0, count: bitWidth)
    print(bitCounts)
    for col in 0..<bitWidth {
        bitCounts[col] = sumBitsForRow(input, bitWidth: bitWidth, col: col)
    }
    return bitCounts
}

// col is 0 indexed from the left:
private func sumBitsForRow(_ input: [UInt16], bitWidth: Int, col: Int) -> Int {
    var count = 0
    let action:  (Bool, UInt16) -> () = { isOne, _ in count = isOne ? count + 1 : count }
    actOnBitsForRow(input, bitWidth: bitWidth, col: col, action: action)
    return count
}

private func actOnBitsForRow(_ input: [UInt16], bitWidth: Int, col: Int, action: (Bool, UInt16) -> () ) {
    for uInt in input {
        // xxxxx row: 2 xIxxx
        // Sum all the bits in each row, divide by count, to get new bit
        let shift = col
        let maskBase = UInt16(0b1<<(bitWidth - 1))
        let mask = UInt16(maskBase>>(shift))
        let testVal = uInt
        action(testVal & mask == mask, uInt)
    }
}

private func toBits(_ input: [Double], pointCount: Int, bitWidth: Int) -> [Int] {
    input.map {
        if $0/Double(pointCount) > 0.5 {
            return 1
        } else {
            return 0
        }
    }
}

private func toUInt16(_ input: [Int]) -> UInt16 {
    var res = UInt16(0)
    let width = input.count
    let mask = UInt16(0b1<<(width-1))
    for bitIndex in 0 ..< input.count {
        if input[bitIndex] == 1 {
            res = res | mask >> bitIndex
        }
    }
    return res
}

public func partTwo() {
    let _in = input
    let binDigs = 12
    let rows = linesToStrings(_in).map { UInt16($0, radix: 2)! }
    let count = rows.count
    print("Part2\n \(count)")
//    let result = onesOrZeros(rows, bitwidth: binDigs, col: 0){ $0 >= $1 }
//    bprint(result)
    print("Oxygen Gen")
    let og = recurBase(rows, bitWidth: binDigs){ $0 >= $1 }
    bprint(og)
    print(og)
    print("CO2")
    let c02 = recurBase(rows, bitWidth: binDigs){ $1 > $0 }
    bprint(c02)
    print(c02)
    print("result: \(UInt32(c02.first!) * UInt32(og.first!))")
}

private func bprint(_ vals: [UInt16]) {
    print(vals.map { String($0, radix: 2) })
}

private func recurBase(_ rows: [UInt16], bitWidth: Int, pred: (Int, Int) -> Bool) -> [UInt16] {
    var res = rows
    for col in 0..<bitWidth {
        if res.count == 1 { continue }
        res = onesOrZeros(res, bitwidth: bitWidth, col: col, pred: pred)
//        bprint(res)
    }
    return res
}


private func onesOrZeros(_ rows: [UInt16], bitwidth: Int, col: Int, pred: (Int, Int) -> Bool) -> [UInt16] {
    var ones = [UInt16]()
    var zeros = [UInt16]()
    var result = [UInt16]()
    actOnBitsForRow(rows, bitWidth: bitwidth, col: col) { isOne, row in
        if isOne {
            ones.append(row)
        } else {
            zeros.append(row)
        }
        result = pred(ones.count,zeros.count) ? ones : zeros
    }
    return result
}
