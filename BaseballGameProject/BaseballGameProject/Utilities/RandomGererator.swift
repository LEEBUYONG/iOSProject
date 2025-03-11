//  Lv.1. ~ LV.2
// 랜덤 함수 Code

import Foundation

//===== LV 1. 랜덤 숫자 생성(배열 -> contains 중복 확인) 사용 =====
struct RandomGenerator {
    func makeAnswer() -> [Int] {
        var answer: [Int] = []
        
        // ===== LV 3. 랜덤 숫자 0도 추가 =====
        while answer.count < 3 {
            var randomNumber = Int.random(in: 0...9)
                if answer.isEmpty {
                    randomNumber = Int.random(in: 1...9)
                    } else {
                        randomNumber = Int.random(in: 0...9)
                    }
            if !answer.contains(randomNumber) { // 중복 체크
                answer.append(randomNumber)
            }
        }
        return answer
    }
}
