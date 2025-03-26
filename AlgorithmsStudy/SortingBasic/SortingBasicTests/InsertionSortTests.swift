
import Testing

@Suite("InsertionSort")
struct InsertionSortTests {
    
    @Test func moveElement() {
        var array = [1, 2, 5, 6, 4, 7] // [1, 2, 5, 5, 6, 7]
        
        // TODO:
        var i = 4
        let key = array[i]
        for j in stride(from: i, to: 0, by: -1) where array[j - 1] > key {
            // TODO:
            array[j] = array[j - 1] //4보다 크다면 오른쪽으로 값 복사
            i -= 1 //i가 어디까지 복사했는지 확인
        }
        
        #expect(array == [1, 1, 5, 5, 6, 7])
        
        // TODO:
        array[i] = key
        
        #expect(array == [1, 2, 4, 5, 6, 7])
    }
    
    @Test func insertionSort() {
        var array = [5, 4, 3, 2, 1]
        let sorted = array.sorted()
        
        // TODO:
        for i in 1..<array.count { //배열을 정렬된 부분과 정렬되지 않은 부분 구분(배열 두번째 요소부터 끝까지 순회) i = 현재 key의 index
            let key = array[i]
            var j = i
            for k in stride(from: i, to: 0, by: -1) {
                if array[k - 1] > key {
                    array[k] = array[k - 1]
                    j -= 1
                }
            }
            array[j] = key
        }
        
        #expect(array == array.sorted())
    }
}
