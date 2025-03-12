// ===== LV 5. GameRecordsManager를 통해 기록 조회 =====

class GameRecordsManager {
    private var records: [Int] = []

    // ----- 기록 추가 -----
    func addRecord(attempts: Int) {
        records.append(attempts)
    }

    // ----- 기록 조회 -----
    func getAllRecords() -> [Int] {
        return records
    }
}

