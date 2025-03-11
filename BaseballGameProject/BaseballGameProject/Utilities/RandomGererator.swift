//  Lv.1. ~ LV.2
// 랜덤 함수 Code

import Foundation

struct RandomGenerator {
    func makeAnswer() -> [Int] {
        var answer: [Int] = []
        
        while answer.count < 3 {
            let randomNumber = Int.random(in: 1...9)
            if !answer.contains(randomNumber) { // 중복 체크
                answer.append(randomNumber)
            }
        }
        return answer
    }
}
