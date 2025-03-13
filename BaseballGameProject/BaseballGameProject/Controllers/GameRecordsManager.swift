// ===== LV 5. GameRecordsManager를 통해 기록 조회 =====

class GameRecordsManager {
    private var records: [Int] = []

    // ----- 기록 추가 -----
    func addRecord(attempts: Int) {
        records.append(attempts)
    }

    // ----- 기록 조회: 기록 없는 경우 처리 03.13. 수정 -----
    func getAllRecords() throws -> [Int] {
        guard !records.isEmpty else {
            throw GameRecordsError.noRecords
        }
        return records
    }
}

// ----- 에러 정의 03.13 수정-----
enum GameRecordsError: Error {
    case noRecords         // 기록이 없는 경우
}
