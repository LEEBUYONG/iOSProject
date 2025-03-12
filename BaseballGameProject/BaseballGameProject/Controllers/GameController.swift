//  Lv.1. ~ LV.2
//  Controller Code

import Foundation

class GameController {
    
    private let randomGenerator = RandomGenerator()
    private let gameView = GameView()
    private let inputHandler = InputHandler()
    private let recordsManager: GameRecordsManager

       init(recordsManager: GameRecordsManager) {
           self.recordsManager = recordsManager
       }
    
    //-----게임 시작 함수-----
    func startGame() {
        let answer = randomGenerator.makeAnswer()
        var attempts = 0 //게임 시도 횟수
        
        while true {
            // ===== LV 1. 사용자 입력 받기 =====
            let userInput = inputHandler.getUserInput()
            //===== LV 5. 시도 횟수 증가 =====
            attempts += 1
            
            // ===== LV 2. inputHandler~gameView_ 입력 내용 필터 =====
            guard inputHandler.isValidInput(userInput) else {
                    gameView.displayInvalidInputMessage()
                    continue
            }
            
            // ===== LV 2. S,B 구분 함수_ 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기 =====
            let (strike, ball) = calculateScore(answer: answer, userInput: userInput)
            
            // ===== LV 2. gameView_ 결과 확인 =====
            gameView.displayResult(strike: strike, ball: ball)
            
            if strike == 3 {
                gameView.displayCorrectAnswerMessage()
                // ===== LV 5. 게임 레코드에 기록 추가 =====
                recordsManager.addRecord(attempts: attempts)
                break
            }
        }
    }
    
    // ===== LV 2. Strike, Ball 구분 함수 =====
    private func calculateScore(answer: [Int], userInput: [Int]) -> (Int, Int) {
        var strike = 0
        var ball = 0
        
        // ===== 입력받은 내역과 정답의 S,B 비교 =====
        for (index, number) in userInput.enumerated() {
            if answer[index] == number {
                strike += 1
            } else if answer.contains(number) {
                ball += 1
            }
        }
        return (strike, ball)
    }
}
