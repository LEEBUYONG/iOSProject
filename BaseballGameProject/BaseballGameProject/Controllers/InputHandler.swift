// Lv.1. ~ LV.2
// 사용자 입력 Code


import Foundation

//===== LV 2. 사용자 입력받기 =====
struct InputHandler {
    func getUserInput() -> [Int] {
        print("숫자를 입력하세요: ")
        guard let input = readLine() else { //옵셔널 바인딩
            return []
        }
        
        //===== 입력된 문자열에서 숫자 배열 생성(03.11 불필요한 형변환 수정) =====
        return input.compactMap { $0.wholeNumberValue }
    }
    
    // ===== 잘못된 입력 처리 =====
    func isValidInput(_ userInput: [Int]) -> Bool {
        return userInput.count == 3 && Set(userInput).count == 3
        //&& !userInput.contains(0)
    }
}

