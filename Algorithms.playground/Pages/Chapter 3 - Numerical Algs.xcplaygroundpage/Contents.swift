import Foundation

// LCG = Linear Congruential Generator
struct LCGRandomizer {
    // set X to seed value
    var X: Int
    
    // typical A, B, M values:
    // Microsoft VB6 -> A = 1140671485, B = 12820163, M = 2^24
    // Microsoft Visual C++ -> A = 214013, B = 2531011, M = 2^32
    // Borland C/C++ -> A = 214013, B = 2531011, M = 2^32
    let A: Int
    let B: Int
    let M: Int
    
    init(X: Int, A: Int, B: Int, M: Int) {
        self.X = X
        self.A = A
        self.B = B
        self.M = M
    }
    
    // rules for A, B, M to achieve full period of random numbers
    // 1. B and M are _relatively_ prime
    // 2. (A - 1) is divisible by all prime factors of M
    // 3. (A - 1) is a multiple of 4 if M is
    //
    // (full period = all numbers below M have been touched
    // by the random numbers generator)
    
    mutating func next() -> Int {
        // formula: X(n+1) = (A * X(n) + B) mod M
        X = (A * X + B) % M
        return X
    }
    
    var current: Int { X }
}
//
//var randomizer = LCGRandomizer(X: 2, A: 26, B: 0, M: 17)
//var set = Set<Int>()
//set.insert(randomizer.current)
//for _ in 0..<120 {
//    print(randomizer.next())
//    set.insert(randomizer.next())
//}
//
//// primality test here
//// resources:
//
//// insert code here...
//
//
// MARK: - array randomization
//
//// only shuffle N first elements with other (N-num) elements in the array
//func getRandomElements(_ array: [Int], howMany num: Int) -> [Int] {
//    var swappedArray = array
//    for i in 0..<num {
//        let j = Int.random(in: 0..<array.count)
//
//        let temp = swappedArray[i]
//        swappedArray[i] = swappedArray[j]
//        swappedArray[j] = temp
//    }
//
//    return Array(swappedArray.prefix(num))
//}
//
//let array = [Int](0...1000000)
//
//let start = Date()
//getRandomElements(array, howMany: 5)
//let end = Date()
//start.distance(to: end)

let B: Int = 5 * 12 * 6 * 48 * 23 * 34 * 12 * 48 * 23 * 45 * 34 * 12 * 23
let A: Int = 5 * 12 * 6 * 48 * 23 * 34 * 12 * 48 * 23 * 45 * 34 * 12 * 123
5 * 12 * 6 * 48 * 23 * 34 * 12 * 48 * 23 * 45 * 34 * 12

var start = Date()
func gcd(_ A: Int, _ B: Int) -> Int {
    if B == 0 { return A }
    else { return gcd(B, A % B) }
}
gcd(5 * 12 * 6 * 48 * 23, 5 * 12 * 6 * 48 * 37)
var end = Date()
start.distance(to: end)

start = Date()
func lcm(_ A: Int, _ B: Int) -> Int {
    return A / gcd(A, B) * B
}
lcm(5 * 12 * 6 * 48 * 23, 5 * 12 * 6 * 48 * 37)
end = Date()
start.distance(to: end)

124 / 2
62 / 2
31

123456789012345678

func primeFactors(of num: Int) -> [Int] {
    var currentNumber = num
    var factors = [Int]()
    
    while currentNumber % 2 == 0 {
        factors.append(2)
        currentNumber /= 2
    }
    
    var divisor = 3
    var stopAt = sqrt(Double(currentNumber))
    while divisor <= Int(stopAt) {
        
        while currentNumber % divisor == 0 {
            factors.append(divisor)
            currentNumber /= divisor
            stopAt = sqrt(Double(currentNumber))
        }
        
        divisor += 2
    }
    
    if currentNumber > 1 { factors.append(currentNumber) }
    return factors
}

primeFactors(of: 204)

// MARK: - sieve of Erastosthenes

let N = 100
// reserve three extra spots for numbers 0, 1, and N
var isPrime = Array.init(repeating: true, count: N + 3)

// since 0 and 1 are NOT prime numbers
(isPrime[0], isPrime[1]) = (false, false)

// because isPrime[2] should be true, cross out all multiples of 2
var number = 2

number += 2 // added for
while number <= N { // for 'crossing out' use <= N
    isPrime[number] = false
    number += 2
}

number = 3
var squareRoot = Int(sqrt(Double(N)).rounded())
while number <= squareRoot { // for prime numbers, use
    if isPrime[number] {
        var multiple = number * number
        while multiple <= N {
            // cross out other multiples of prime^2: odd numbers only,
            // hence `mulitiple += 2 * number`
            isPrime[multiple] = false
            
            multiple += (2 * number)
        }
    }
    number += 2
}

var primes = [Int]()
for p in 2...N {
    if isPrime[p] { primes.append(p) }
}

primes

// MARK: - Fermat's little theorem

let prime: Double = 191

let trials: Double = 16
var passes: Double = 0
for _ in 1...16 {
    let random = Double.random(in: 1..<prime).rounded()
    let temp = pow(Double(random), Double(prime - 1))
    let modulus = temp.truncatingRemainder(dividingBy: prime)
    if modulus == 1 {
        passes += 1
    }
}

// percentage of passes
(passes / trials) * 100
