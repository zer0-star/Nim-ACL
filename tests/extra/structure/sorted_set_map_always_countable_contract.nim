import atcoder/extra/structure/sorted_set_map


template insertSetValue(container, value: untyped): untyped =
  discard container.insert(value)


template insertMapValue(
    container,
    key,
    value: untyped
): untyped =
  when compiles(container[key] = value):
    container[key] = value

  elif compiles(container.insert(key, value)):
    discard container.insert(key, value)

  elif compiles(container.insert((key, value))):
    discard container.insert((key, value))

  else:
    {.error: "unsupported map insertion API".}


template checkSet(container: untyped) =
  insertSetValue(container, 30)
  insertSetValue(container, 10)
  insertSetValue(container, 20)

  doAssert *container{0} == 10
  doAssert *container{1} == 20
  doAssert *container{2} == 30

  doAssert container.kth_element(0) == container{0}
  doAssert container.kth_element(1) == container{1}
  doAssert container.kth_element(2) == container{2}

  doAssert container{0}.index == 0
  doAssert container{1}.index == 1
  doAssert container{2}.index == 2

  doAssert container.distance(
    container.begin(),
    container.end(),
  ) == 3

  doAssert distance(
    container.begin(),
    container.end(),
  ) == 3


template checkMultiSet(container: untyped) =
  insertSetValue(container, 2)
  insertSetValue(container, 1)
  insertSetValue(container, 2)
  insertSetValue(container, 3)

  doAssert *container{0} == 1
  doAssert *container{1} == 2
  doAssert *container{2} == 2
  doAssert *container{3} == 3


template checkMap(container: untyped) =
  insertMapValue(container, 30, "thirty")
  insertMapValue(container, 10, "ten")
  insertMapValue(container, 20, "twenty")

  when compiles(container[20] == "twenty"):
    doAssert container[20] == "twenty"

  doAssert *container{0} == (10, "ten")
  doAssert *container{1} == (20, "twenty")
  doAssert *container{2} == (30, "thirty")

  doAssert container.kth_element(1) == container{1}
  doAssert container{1}.index == 1


var defaultSet = initSortedSet[int]()
var trueSet = initSortedSet[int](countable = true)
var falseSet = initSortedSet[int](countable = false)

checkSet(defaultSet)
checkSet(trueSet)
checkSet(falseSet)


var defaultMultiSet = initSortedMultiSet[int]()
var trueMultiSet = initSortedMultiSet[int](countable = true)
var falseMultiSet = initSortedMultiSet[int](countable = false)

checkMultiSet(defaultMultiSet)
checkMultiSet(trueMultiSet)
checkMultiSet(falseMultiSet)


var defaultMap = initSortedMap[int, string]()
var trueMap = initSortedMap[int, string](countable = true)
var falseMap = initSortedMap[int, string](countable = false)

checkMap(defaultMap)
checkMap(trueMap)
checkMap(falseMap)


var defaultMultiMap = initSortedMultiMap[int, string]()
var trueMultiMap = initSortedMultiMap[int, string](countable = true)
var falseMultiMap = initSortedMultiMap[int, string](countable = false)

checkMap(defaultMultiMap)
checkMap(trueMultiMap)
checkMap(falseMultiMap)


var iterationSet = initSortedSet[int]()

for value in [3, 1, 2]:
  discard iterationSet.insert(value)

var implicitItems = ""

for value in iterationSet:
  implicitItems.add($value)

doAssert implicitItems == "123"

var explicitItems = ""

for value in iterationSet.items:
  explicitItems.add($value)

doAssert explicitItems == "123"


var iterationMap = initSortedMap[int, string]()

iterationMap[2] = "two"
iterationMap[1] = "one"

var implicitPairs = ""

for key, value in iterationMap:
  implicitPairs.add($key & ":" & value & ";")

doAssert implicitPairs == "1:one;2:two;"

var explicitPairs = ""

for key, value in iterationMap.pairs:
  explicitPairs.add($key & ":" & value & ";")

doAssert explicitPairs == "1:one;2:two;"


let found = iterationSet.find(2)
doAssert found != iterationSet.end()
doAssert *found == 2

let lower = iterationSet.lower_bound(2)
let upper = iterationSet.upper_bound(2)

doAssert *lower == 2
doAssert *upper == 3

var forwardIterator = iterationSet.begin()
doAssert *forwardIterator == 1

forwardIterator.inc
doAssert *forwardIterator == 2

var backwardIterator = iterationSet.end()
backwardIterator.dec

doAssert *backwardIterator == 3

echo "SORTED_ALWAYS_COUNTABLE_OK"
echo "SORTED_ORDER_ACCESS_OK"
echo "SORTED_MAP_KEY_VS_INDEX_OK"
echo "SORTED_ITERATOR_API_OK"
