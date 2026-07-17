type
  UInt256Limbs* = array[4, uint64]
  UInt512Limbs* = array[8, uint64]

func isZero4*(
    value: UInt256Limbs,
): bool =
  for limb in value:
    if limb != 0'u64:
      return false

  true

func compare4*(
    a,
    b: UInt256Limbs,
): int =
  for index in countdown(3, 0):
    if a[index] < b[index]:
      return -1

    if a[index] > b[index]:
      return 1

  0

func add4*(
    a,
    b: UInt256Limbs,
): tuple[
    value: UInt256Limbs,
    carry: bool,
] =
  var carryWord =
    0'u64

  for index in 0 ..< 4:
    let first =
      a[index] + b[index]

    let firstCarry =
      first < a[index]

    let second =
      first + carryWord

    let secondCarry =
      second < first

    result.value[index] =
      second

    if firstCarry or secondCarry:
      carryWord =
        1'u64
    else:
      carryWord =
        0'u64

  result.carry =
    carryWord != 0'u64

func sub4*(
    a,
    b: UInt256Limbs,
): tuple[
    value: UInt256Limbs,
    borrow: bool,
] =
  var borrowWord =
    0'u64

  for index in 0 ..< 4:
    let first =
      a[index] - b[index]

    let firstBorrow =
      a[index] < b[index]

    let second =
      first - borrowWord

    let secondBorrow =
      first < borrowWord

    result.value[index] =
      second

    if firstBorrow or secondBorrow:
      borrowWord =
        1'u64
    else:
      borrowWord =
        0'u64

  result.borrow =
    borrowWord != 0'u64

func shiftLeftOne4*(
    value: UInt256Limbs,
): UInt256Limbs =
  var carry =
    0'u64

  for index in 0 ..< 4:
    let nextCarry =
      value[index] shr 63

    result[index] =
      (value[index] shl 1) or carry

    carry =
      nextCarry

func shiftRightOne4*(
    value: UInt256Limbs,
): UInt256Limbs =
  var carry =
    0'u64

  for index in countdown(3, 0):
    let nextCarry =
      value[index] and 1'u64

    result[index] =
      (value[index] shr 1) or
      (carry shl 63)

    carry =
      nextCarry

func getBit4*(
    value: UInt256Limbs,
    index: range[0 .. 255],
): bool =
  let limbIndex =
    int(index) shr 6

  let bitIndex =
    int(index) and 63

  (
    value[limbIndex] and
    (1'u64 shl bitIndex)
  ) != 0'u64

proc setBit4*(
    value: var UInt256Limbs,
    index: range[0 .. 255],
) =
  let limbIndex =
    int(index) shr 6

  let bitIndex =
    int(index) and 63

  value[limbIndex] =
    value[limbIndex] or
    (1'u64 shl bitIndex)
