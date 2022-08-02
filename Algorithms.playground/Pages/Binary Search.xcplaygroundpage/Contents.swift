/*
 Binary Search (Бинарный поиск)
 
 Бинарный поиск - это алгоритм; на входе он получает отсортированный список элементов. Если элемент, который вы ищете, присутствует в списке, то бинарный поиск возвращает ту позицию, в которой он был найден. В противном слу­чае бинарный поиск возвращает null.
 
 Сложность: O(log n) или увеличение кол-ва элементов в 10 раз увеличиваем кол-ва операций в двое
 Массив из 100 элементов -> 7 операций
 Массив из 1000 элементов -> 10 операций
 Массив из 10000 элементов -> 14 операций
 */

func binarySearch<T: Comparable>(_ inputArr:Array<T>, _ searchItem: T) -> Int? {
    print("Searching for \(searchItem) in \(inputArr)")
    var lowerIndex = 0 // нижняя граница поиска
    var higherIndex = inputArr.count - 1 // верхняя граница поиска
    
    
    while (true) {
        let currentIndex = (lowerIndex + higherIndex) / 2 // проверяем центральный элемент
        if inputArr[currentIndex] == searchItem { //если елемент соответсвует искомому...
            return currentIndex // ...то возвращаем его
        } else if lowerIndex > higherIndex { // если нижняя граница стала больше верхней...
            return nil // ... то элемента нет в массиве
        } else { // если элемент не соответсвует искомому и нижняя граница меньше верхней...
            if inputArr[currentIndex] > searchItem { // ... если центральный элемент больше искомого
                higherIndex = currentIndex - 1 // ... уменьшаем верхнюю границу поиска
            } else { // ... центральный элемент меньше искомого
                lowerIndex = currentIndex + 1 //... увеличиваем нижнюю границу поиска
            }
        }
    }
    
}

// Example with: Ints

var dataArray: [Int] = []
for i in 0...15 {
    dataArray.append(i)
}
let randomNumber = dataArray.randomElement()!

binarySearch(dataArray, randomNumber)


// Example with: Stings

var dataSet = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"].sorted()

let randomString = dataSet.randomElement()!

binarySearch(dataSet, randomString)

// Example with: nil

binarySearch(dataArray, -1)
