
import Testing
import Foundation

@Suite("SelectionSort")
struct SelectionSortTests {
    
    func isSorted(_ array: [Int]) -> Bool {
        // TODO:
        for i in 0..<array.count - 1 { //맨 마지막 요소 빼고 반복
            if array[i] > array [i + 1] {
                return false
            }
        }
        return true
    }
    
    @Test func checkSorted() {
        let array0 = [1, 2, 2, 4, 5]
        let array1 = [5, 4, 3, 2, 1]
        
        #expect(isSorted(array0))
        #expect(!isSorted(array1))
    }
    
    @Test func findMin() {
        let array = [8, 4, 6, 2, 1, 1, 10, 7, 8]
        var minNumber: Int = array[0]
        
        // TODO:
        for num in array { //맨 마지막 요소 빼고 반복
            if num < minNumber {
                minNumber = num
            }
        }
        #expect(minNumber == array.min())
    }
    
    @Test func findMinIndex() {
        let array = [8, 4, 6, 2, 1, 1, 10, 7, 8]
        var minIndex = 0
        
        // TODO:
        for i in array.indices {
            if array[i] < array[minIndex] {
                minIndex = i
            }
        }
        #expect(minIndex == array.firstIndex(of: array.min()!))
    }
    
    @Test func selectionSort() {
        var array = [8, 4, 6, 2, 1, 1, 10, 7, 8] // [1, 1, 2, 7, 6, 8..., ]
        let sorted = array.sorted()
        
        // TODO:
        for i in array.indices {
            var minIndex = i
            for j in i + 1..<array.count {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            array.swapAt(i, minIndex)
        }
        #expect(array == sorted)
    }
}
