// ===== AppController 클래스: GameController -> AppController로  메인 컨트롤러 변경 / 전체 앱의 흐름을 관리 =====


class AppController {
    // ===== 프로퍼티 -> 게임 기록 객체 / 게임 컨트롤러 객체 =====
    private let recordsManager = GameRecordsManager()
    private var gameController: GameController

    // ===== GameController 초기화 시 recordsManager 전달 =====
    init() {
        gameController = GameController(recordsManager: recordsManager)
    }

    func runApp() {
        while true {
            // ===== LV 4. 메뉴 출력 =====
            print("""
            환영합니다! 원하시는 번호를 입력해주세요
            1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기
            """)

            // ===== LV 4 . 사용자 입력 받기 =====
            guard let input = readLine(), let choice = Int(input) else {
                print("유효한 숫자를 입력해주세요!")
                continue
            }

            // ===== LV 4. 메뉴 선택 처리 =====
            switch choice {
            case 1:
                print("< 게임을 시작합니다 >")
                gameController.startGame()
            case 2:
                print("< 게임 기록 보기 >")
                showGameRecords()
            // ===== LV 6. 게임 종료 =====
            case 3:
                print("게임을 종료합니다. 안녕히 가세요!")
                return
            default:
                print("1, 2, 3 중에서 선택해주세요!")
            }
        }
    }

    // ===== LV 5. GameRecordsManager를 통해 기록 조회(출력) =====
    private func showGameRecords() {
        let records = recordsManager.getAllRecords()
        if records.isEmpty {
            print("아직 완료한 게임이 없습니다.")
        } else {
            for (index, attempts) in records.enumerated() {
                print("\(index + 1)번째 게임 : 시도 횟수 - \(attempts)")
            }
        }
    }
}
