when not declared ATCODER_EXTRA_STRUCTURE_DENSE_SPARSE_TABLE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_DENSE_SPARSE_TABLE_2D_HPP* = 1

  import std/sequtils
  import atcoder/extra/monoid/monoid

  type
    DenseSparseTable2D*[
        CM: CommutativeMonoid
    ] = object
      heightValue:
        int
      widthValue:
        int
      rowLogs:
        seq[int]
      colLogs:
        seq[int]
      table:
        seq[
          seq[
            seq[
              seq[
                CM.value_type
              ]
            ]
          ]
        ]

  proc buildLevels[
      CM: CommutativeMonoid
  ](
      sparseTable:
        var DenseSparseTable2D[CM],
      base:
        seq[
          seq[
            CM.value_type
          ]
        ]
  ) =
    sparseTable.rowLogs =
      newSeq[int](
        sparseTable.heightValue + 1
      )

    sparseTable.colLogs =
      newSeq[int](
        sparseTable.widthValue + 1
      )

    if sparseTable.heightValue >= 2:
      for length in 2 .. sparseTable.heightValue:
        sparseTable.rowLogs[length] =
          sparseTable.rowLogs[
            length shr 1
          ] + 1

    if sparseTable.widthValue >= 2:
      for length in 2 .. sparseTable.widthValue:
        sparseTable.colLogs[length] =
          sparseTable.colLogs[
            length shr 1
          ] + 1

    let rowLevelCount =
      if sparseTable.heightValue == 0:
        1
      else:
        sparseTable.rowLogs[
          sparseTable.heightValue
        ] + 1

    let colLevelCount =
      if sparseTable.widthValue == 0:
        1
      else:
        sparseTable.colLogs[
          sparseTable.widthValue
        ] + 1

    sparseTable.table =
      newSeq[
        seq[
          seq[
            seq[
              CM.value_type
            ]
          ]
        ]
      ](
        rowLevelCount
      )

    for rowLevel in 0 ..< rowLevelCount:
      sparseTable.table[rowLevel] =
        newSeq[
          seq[
            seq[
              CM.value_type
            ]
          ]
        ](
          colLevelCount
        )

    sparseTable.table[0][0] =
      base

    for colLevel in 1 ..< colLevelCount:
      let halfWidth =
        1 shl (colLevel - 1)

      let blockWidth =
        1 shl colLevel

      let colCount =
        sparseTable.widthValue -
        blockWidth +
        1

      sparseTable.table[0][colLevel] =
        newSeqWith(
          sparseTable.heightValue,
          newSeqWith(
            colCount,
            CM.e(),
          ),
        )

      for row in 0 ..< sparseTable.heightValue:
        for col in 0 ..< colCount:
          sparseTable.table[0][colLevel][row][col] =
            CM.op(
              sparseTable.table[
                0
              ][
                colLevel - 1
              ][
                row
              ][
                col
              ],
              sparseTable.table[
                0
              ][
                colLevel - 1
              ][
                row
              ][
                col + halfWidth
              ],
            )

    for rowLevel in 1 ..< rowLevelCount:
      let halfHeight =
        1 shl (rowLevel - 1)

      let blockHeight =
        1 shl rowLevel

      let rowCount =
        sparseTable.heightValue -
        blockHeight +
        1

      for colLevel in 0 ..< colLevelCount:
        let blockWidth =
          1 shl colLevel

        let colCount =
          sparseTable.widthValue -
          blockWidth +
          1

        sparseTable.table[rowLevel][colLevel] =
          newSeqWith(
            rowCount,
            newSeqWith(
              colCount,
              CM.e(),
            ),
          )

        for row in 0 ..< rowCount:
          for col in 0 ..< colCount:
            sparseTable.table[rowLevel][colLevel][row][col] =
              CM.op(
                sparseTable.table[
                  rowLevel - 1
                ][
                  colLevel
                ][
                  row
                ][
                  col
                ],
                sparseTable.table[
                  rowLevel - 1
                ][
                  colLevel
                ][
                  row + halfHeight
                ][
                  col
                ],
              )

  proc initDenseSparseTable2D*[
      CM: CommutativeMonoid
  ](
      height,
      width: int,
      _: typedesc[CM]
  ): DenseSparseTable2D[CM] =
    ## Constructs an identity-filled static H x W table.
    ##
    ## The operation supplied by CM must additionally satisfy:
    ##
    ## CM.op(x, x) == x
    ##
    ## because rectangle queries combine overlapping blocks.

    doAssert height >= 0
    doAssert width >= 0

    result.heightValue =
      height

    result.widthValue =
      width

    let base =
      newSeqWith(
        height,
        newSeqWith(
          width,
          CM.e(),
        ),
      )

    result.buildLevels(
      base
    )

  proc initDenseSparseTable2D*[
      CM: CommutativeMonoid
  ](
      values:
        seq[
          seq[
            CM.value_type
          ]
        ],
      _: typedesc[CM]
  ): DenseSparseTable2D[CM] =
    ## Builds from values[row][col].
    ##
    ## A zero-row matrix cannot encode a positive logical width;
    ## use the dimension constructor for that case.

    let height =
      values.len

    let width =
      if height == 0:
        0
      else:
        values[0].len

    for row in 0 ..< height:
      doAssert values[row].len == width

    result.heightValue =
      height

    result.widthValue =
      width

    result.buildLevels(
      values
    )

  proc height*[
      CM: CommutativeMonoid
  ](
      sparseTable:
        DenseSparseTable2D[CM]
  ): int {.inline.} =
    sparseTable.heightValue

  proc width*[
      CM: CommutativeMonoid
  ](
      sparseTable:
        DenseSparseTable2D[CM]
  ): int {.inline.} =
    sparseTable.widthValue

  proc get*[
      CM: CommutativeMonoid
  ](
      sparseTable:
        DenseSparseTable2D[CM],
      row,
      col: int
  ): CM.value_type {.inline.} =
    doAssert 0 <= row
    doAssert row < sparseTable.heightValue
    doAssert 0 <= col
    doAssert col < sparseTable.widthValue

    sparseTable.table[0][0][row][col]

  proc prod*[
      CM: CommutativeMonoid
  ](
      sparseTable:
        DenseSparseTable2D[CM],
      rowBegin,
      rowEnd,
      colBegin,
      colEnd: int
  ): CM.value_type =
    ## Returns the product over:
    ##
    ## [rowBegin, rowEnd) x [colBegin, colEnd).
    ##
    ## CM must be associative, commutative and idempotent.

    doAssert 0 <= rowBegin
    doAssert rowBegin <= rowEnd
    doAssert rowEnd <= sparseTable.heightValue
    doAssert 0 <= colBegin
    doAssert colBegin <= colEnd
    doAssert colEnd <= sparseTable.widthValue

    if rowBegin == rowEnd or
       colBegin == colEnd:
      return CM.e()

    let rowLevel =
      sparseTable.rowLogs[
        rowEnd - rowBegin
      ]

    let colLevel =
      sparseTable.colLogs[
        colEnd - colBegin
      ]

    let rowBlockSize =
      1 shl rowLevel

    let colBlockSize =
      1 shl colLevel

    let bottomRow =
      rowEnd - rowBlockSize

    let rightCol =
      colEnd - colBlockSize

    let topLeft =
      sparseTable.table[
        rowLevel
      ][
        colLevel
      ][
        rowBegin
      ][
        colBegin
      ]

    let topRight =
      sparseTable.table[
        rowLevel
      ][
        colLevel
      ][
        rowBegin
      ][
        rightCol
      ]

    let bottomLeft =
      sparseTable.table[
        rowLevel
      ][
        colLevel
      ][
        bottomRow
      ][
        colBegin
      ]

    let bottomRight =
      sparseTable.table[
        rowLevel
      ][
        colLevel
      ][
        bottomRow
      ][
        rightCol
      ]

    CM.op(
      CM.op(
        topLeft,
        topRight,
      ),
      CM.op(
        bottomLeft,
        bottomRight,
      ),
    )

  proc allProd*[
      CM: CommutativeMonoid
  ](
      sparseTable:
        DenseSparseTable2D[CM]
  ): CM.value_type {.inline.} =
    sparseTable.prod(
      0,
      sparseTable.heightValue,
      0,
      sparseTable.widthValue,
    )

  proc `[]`*[
      CM: CommutativeMonoid
  ](
      sparseTable:
        DenseSparseTable2D[CM],
      row,
      col: int
  ): CM.value_type {.inline.} =
    sparseTable.get(
      row,
      col,
    )
