//  Lv.1. ~ LV.2
// 랜덤 함수 Code

import Foundation

//===== LV 1. 랜덤 숫자 생성(배열 -> contains 중복 확인) 사용 =====
struct RandomGenerator {
    func makeAnswer() -> [Int] {
        var answer: [Int] = []
        
        // ===== LV 3. 랜덤 숫자 0도 추가 =====
        while answer.count < 3 {
            var randomNumber: Int //03.12. 값 재할당에 따른 데드코드 수정(선언만 진행)
                if answer.isEmpty {
                    randomNumber = Int.random(in: 1...9)
                    } else {
                        randomNumber = Int.random(in: 0...9)
                    }
            if !answer.contains(randomNumber) { // contiains로 중복 체크
                answer.append(randomNumber)
            }
        }
        return answer
    }
}
