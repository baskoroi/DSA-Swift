import Foundation

class Cell<T>: Equatable where T: Comparable {
    static func == (lhs: Cell<T>, rhs: Cell<T>) -> Bool {
        return lhs.value == rhs.value && lhs.next == rhs.next
    }
    
    var value: T?
    var next: Cell?
    
    init() {
        self.value = nil
        self.next = nil
    }
    
    init(value: T?, next: Cell?) {
        self.value = value
        self.next = next
    }
}

class LinkedList<T> where T: Comparable {

    private var sentinel = Cell<T>()
    
    var count = 0

    var first: Cell<T>? { sentinel.next }
    
    var isEmpty: Bool { first == nil }
    
    func prepend(value: T) {
        insert(at: 0, value: value)
    }
    
    func append(value: T) {
        insert(at: count, value: value)
    }
    
    func insert(at index: Int, value: T) {
        
        var beforeIndex = -1
        var before = sentinel
        
        // while the cell after still exists, and while we haven't reached the cell after
        while let next = before.next, beforeIndex + 1 < index {
            before = next
            beforeIndex += 1
        }
        
        insert(before: before, value: value)
    }
    
    private func insert(before: Cell<T>, value: T) {
        let newNode = Cell<T>(value: value, next: nil)
        
        newNode.next = before.next
        before.next = newNode
        
        count += 1
    }
    
    func insertBySort(value: T) {
        var before = sentinel
        while let next = before.next, let nextValue = next.value, nextValue < value {
            before = next
        }
        insert(before: before, value: value)
    }
    
    func remove(value: T) {
        var before = sentinel
        while let next = before.next, next.value != value {
            before = next
        }
        
        var temp = before.next
        before.next = temp?.next
        temp = nil // 'erase' the reference
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        var string = "[ "
        
        var cell = sentinel.next
        while cell != nil {
            guard let value = cell?.value else { break }
            string += "( \(value) )"
            
            if let next = cell?.next {
                cell = next
                string += " -> "
            } else {
                break
            }
        }
        
        return string + " ]"
    }
}

let list = LinkedList<Int>()
//list.insert(at: 0, value: 1)
//list.insert(at: 0, value: 2)
//list.insert(at: 0, value: 3)
//list.insert(at: 1, value: 4)
//list.insert(at: 3, value: 5)
//list.insert(at: -1, value: -1)
//list.insert(at: -10, value: -10)
//list.insert(at: 2300, value: 2300)
//list.prepend(value: -100)
//list.append(value: 1000000)

list.insertBySort(value: 71)
list.insertBySort(value: 22)
list.insertBySort(value: 313)
list.insertBySort(value: 44)
list.insertBySort(value: 524)
list.insertBySort(value: -1)
list.insertBySort(value: -10)
list.insertBySort(value: 2300)
list.insertBySort(value: -100)
list.insertBySort(value: 1000000)

list.remove(value: 313)
list.remove(value: 1000000)
list.remove(value: 517)
list.remove(value: -100)

let list2 = LinkedList<Int>()
list2.append(value: 123)
list2.append(value: 234)
list2.remove(value: 123)

print(list)
print(list2)
