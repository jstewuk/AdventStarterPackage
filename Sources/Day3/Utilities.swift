
public func linesToStrings(_ input: String) -> [String] {
    input.split(separator: "\n").map { "\($0)" }
}
