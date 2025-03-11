// Lv.1. ~ LV.2
// 사용자 입력 Code


import Foundation

struct InputHandler {
    func getUserInput() -> [Int] {
        print("숫자를 입력하세요: ")
        guard let input = readLine(), let userInputNumber = Int(input) else {
            return []
        }
        return String(userInputNumber).compactMap { $0.wholeNumberValue }
    }
    
    func isValidInput(_ userInput: [Int]) -> Bool {
        return userInput.count == 3 && Set(userInput).count == 3 && !userInput.contains(0)
    }
}
