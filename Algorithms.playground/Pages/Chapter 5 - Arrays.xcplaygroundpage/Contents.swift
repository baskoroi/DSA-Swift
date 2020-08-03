import Foundation

// MARK: - statistical values (median, variance, standard deviation, etc.?)
//var a = [11, 2, 3, 19, 6, 8, 20]
//var b = [Int]()
//
//for _ in 0..<8 {
//    b.append(Int.random(in: 1...20))
//}
//
//b.sorted()
//
//func median(of nums: [Int]) -> Double {
//    var array = nums
//    while array.count != 1 && array.count != 2 {
//        if let min = array.min(),
//           let minIndex = array.firstIndex(of: min) {
//
//            array.remove(at: minIndex)
//        }
//
//        if let max = array.max(),
//           let maxIndex = array.firstIndex(of: max) {
//
//            array.remove(at: maxIndex)
//        }
//    }
//
//    if array.count == 1 { return Double(array[0]) }
//    else { return Double(array[0] + array[1]) / 2.0 }
//}
//
//median(of: a)
//median(of: b)

// MARK: - triangular array

// a triangular array is like the Pearson correlation matrix or
// a matrix of distances between cities in a given region

// makes default value for any generic type
struct TriangularArray {
    // number of rows in the triangular array
    let numRows: Int
    
    // values, mapped from 2D to 1D here
    var values: [String]
    
    init(numRows: Int) {
        self.numRows = numRows
        self.values = Array.init(repeating: "", count: (numRows * (numRows - 1) / 2))
    }
    
    func getValue(row: Int, column: Int) -> String {
        let index = indexOf(row: row, column: column)
        return values[index]
    }
        
    mutating func setValue(_ value: String, row: Int, column: Int) {
        let index = indexOf(row: row, column: column)
        values[index] = value
    }
    
    private func correctIndices(row: Int, column: Int) -> (Int, Int) {
        precondition((row >= 0 && row < numRows) &&
                     (column >= 0 && column < numRows),
                     "Row and column indices are out of bounds!")
        
        // swap row and column, if row is less than column
        // (i.e. the duplicate value in the matrix)
        return row < column ? (column, row) : (row, column)
    }
    
    private func indexOf(row: Int, column: Int) -> Int {
        let (row, column) = correctIndices(row: row, column: column)
        
        return row * (row - 1) / 2 + column
    }
}

var ta = TriangularArray(numRows: 4)
ta.setValue("basko", row: 1, column: 2)
ta.getValue(row: 1, column: 2)
ta.getValue(row: 2, column: 1)
ta.getValue(row: 2, column: 3)
ta

// MARK: - sparse arrays

class ArrayRow<T> where T: Comparable {
  var rowNumber: Int?
  var nextRow: ArrayRow<T>?
  // no value or column number, and a nil next reference
  var rowSentinel = ArrayCell<T>()
}

class ArrayCell<T> where T: Comparable {
  var columnNumber: Int?
  var value: T?
  var nextCell: ArrayCell<T>?
}

class SparseArray<T> where T: Comparable {
  var row: ArrayRow<T>
  
  init() {
    row = ArrayRow<T>()
  }
  
  func findRowBefore(index rowNumber: Int) -> ArrayRow<T>? {
    var rowBefore = row
    while let nextRow = rowBefore.nextRow,
          let nextRowNumber = nextRow.rowNumber,
          nextRowNumber < rowNumber {
      
      rowBefore = nextRow
    }
    
    if rowBefore.rowNumber == rowNumber { return rowBefore }
    else { return nil }
  }
  
  func findCellBefore(index columnNumber: Int, rowSentinel: ArrayCell<T>) -> ArrayCell<T>? {
    var cellBefore = rowSentinel
    while let nextCell = cellBefore.nextCell,
          let nextColumnNumber = nextCell.columnNumber,
          nextColumnNumber < columnNumber {
      
      cellBefore = nextCell
    }
    
    if cellBefore.columnNumber == columnNumber { return cellBefore }
    else { return nil }
  }
  
  func getValue(row: Int, column: Int) -> T? {
    let rowBefore = findRowBefore(index: row)
    
  }
}
