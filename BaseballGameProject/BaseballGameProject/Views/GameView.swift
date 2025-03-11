//  Lv.1. ~ LV.2
// CMD 메시지 출력 Code

import Foundation

// ===== LV 2. 출력문 관리 =====
struct GameView {
    func displayInvalidInputMessage() {
        print("올바르지 않은 입력값입니다")
    }
    
    // ===== S,B 구분하여 출력 =====
    func displayResult(strike: Int, ball: Int) {
        if ball == 0 && strike == 0 {
            print("Nothing")
        } else {
            print("\(strike)스트라이크 \(ball)볼")
        }
    }

    func displayCorrectAnswerMessage() {
        print("정답입니다")
    }
}
