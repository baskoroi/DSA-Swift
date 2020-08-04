import Foundation

var s = ["CAMPRET->Abasi", "CAMPRET->", "CAMPRET->Tosin"]
let a = s[0..<1]
type(of: a)
s.sorted()

struct Sorter {
    func insertionSort(_ array: [Int]) -> [Int] {
        var result = array
        let count = result.count
        
        for i in 1..<count {
            var j = i
            while j - 1 >= 0 && result[j] < result[j-1] {
                let temp = result[j]
                result[j] = result[j - 1]
                result[j - 1] = temp
                
                j -= 1
            }
        }
        
        return result
    }
    
    func selectionSort(_ array: [Int]) -> [Int] {
        var result = array
        let count = result.count
        
        for i in 0..<count-1 {
            var minIndex = i
            for j in i+1..<count {
                if result[j] < result[minIndex] {
                    minIndex = j
                }
            }
            if minIndex != i {
                let temp = result[minIndex]
                result[minIndex] = result[i]
                result[i] = temp
            }
        }
        
        return result
    }
        
    func quicksort(_ array: [Int]) -> [Int] {
        if array.count <= 1 {
            return array
        }
        if array.count == 2 {
            let minItem = min(array[0], array[1])
            let maxItem = max(array[0], array[1])
            return [minItem, maxItem]
        }
        
        // divide array
        let (leftArray, middleArray, rightArray) = partition(array)
        
        // return with quicksorted partitions / divisions
        return quicksort(leftArray) + middleArray + quicksort(rightArray)
    }
    
    private func partition(_ array: [Int]) -> ([Int], [Int], [Int]) {
        var array = array
        let count = array.count
        
        let dividerIndex = Int.random(in: 0...count-1)
        
        // divider leaves a hole, but later inserted in middle of array
        var divider = array[dividerIndex]
        
        // swap divider with the array's first item
        let tempDivider = array[dividerIndex]
        array[dividerIndex] = array[0]
        array[0] = tempDivider
        
        var (hole, left, right) = (0, 1, count - 1)
        while left <= right {
            
            // make sure hole is within bounds
            guard hole >= 0 && hole < count else { break }
            
            // is left smaller than divider?
            // if yes: increment until we find any item bigger
            // than our chosen divider
            // why? because current item is already smaller than divider
            // which should be the case for numbers on the left side
            //
            // if not: ready to swap with actual minValue
            while array[left] <= divider && left < count - 1 { left += 1 }
            
            // same for right side: decrement right until we find any
            // item smaller than divider
            while array[right] >= divider && right > 0 { right -= 1 }
            
            // check whether hole is left side or right side
            // left => find min value, right => find max value
            if hole < left {
                
                // find minimum value & index, betw. items at left & right
                let minValue = min(array[left], array[right])
                let minIndex = minValue == array[left] ? left : right
                
                // if min value is smaller than divider,
                // put min value inside hole, and switch hole to previous
                // minValue
                // and increment the left index (next num)
                if minValue < divider {
                    array[hole] = minValue
                    hole = minIndex
                    if (left + 1 <= (count - 1)) && hole == left {
                        left += 1
                    } else if (right - 1 >= 0) && hole == right {
                        right -= 1
                    }
                }
                
            } else if hole > right {
                
                let maxValue = max(array[left], array[right])
                let maxIndex = maxValue == array[left] ? left : right
                
                // swap maxValue with hole, if maxValue is bigger than divider
                // as hole is on the right side (i.e. needs items larger
                // than divider)
                if maxValue > divider {
                    array[hole] = maxValue
                    hole = maxIndex
                    if (left + 1 <= (count - 1)) && hole == left {
                        left += 1
                    } else if (right - 1 >= 0) && hole == right {
                        right -= 1
                    }
                }
            } else {
                break
            }
        }
        
        // revalidate hole's position since it has possibly been moved
        if hole - 1 >= 0 && divider < array[hole-1] {
            let temp = divider
            divider = array[hole-1]
            array[hole-1] = temp
        } else if hole + 1 < count && divider > array[hole+1] {
            let temp = divider
            divider = array[hole+1]
            array[hole+1] = temp
        }
        
        array[hole] = divider
        
        let leftArray = Array(array[0..<hole])
        let middleArray = [divider] // turn divider into an array
        let rightArray = Array(array[hole+1..<count])
        
        return (leftArray, middleArray, rightArray)
    }
}

var arr = [Int]()
for _ in 0..<1000 {
    arr.append(Int.random(in: 1...999999999))
}

let sorter = Sorter()
let sorted1 = sorter.selectionSort(arr)
let sorted2 = sorter.quicksort(arr)
sorted1 == sorted2
