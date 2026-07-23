when not declared ATCODER_EXTRA_STRUCTURE_DENSE_DISJOINT_SPARSE_TABLE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_DENSE_DISJOINT_SPARSE_TABLE_2D_HPP* = 1

  import std/sequtils
  import atcoder/extra/monoid/monoid

  type
    DenseDisjointSparseTable2D*[
        CM: CommutativeMonoid
    ] = object
      heightValue:
        int
      widthValue:
        int
      rowLevelCount:
        int
      colLevelCount:
        int
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

  proc highestBitIndex(
      value: int
  ): int {.inline.} =
    doAssert value > 0

    var remaining =
      value

    while (remaining shr 1) > 0:
      result.inc
      remaining =
        remaining shr 1

  proc buildLevels[
      CM: CommutativeMonoid
  ](
      disjointTable:
        var DenseDisjointSparseTable2D[CM],
      values:
        seq[
          seq[
            CM.value_type
          ]
        ]
  ) =
    disjointTable.rowLevelCount =
      0

    var rowSpan =
      1

    while rowSpan < disjointTable.heightValue:
      disjointTable.rowLevelCount.inc
      rowSpan =
        rowSpan shl 1

    disjointTable.colLevelCount =
      0

    var colSpan =
      1

    while colSpan < disjointTable.widthValue:
      disjointTable.colLevelCount.inc
      colSpan =
        colSpan shl 1

    let rowSlotCount =
      disjointTable.rowLevelCount + 1

    let colSlotCount =
      disjointTable.colLevelCount + 1

    disjointTable.table =
      newSeq[
        seq[
          seq[
            seq[
              CM.value_type
            ]
          ]
        ]
      ](
        rowSlotCount
      )

    for rowSlot in 0 ..< rowSlotCount:
      disjointTable.table[rowSlot] =
        newSeq[
          seq[
            seq[
              CM.value_type
            ]
          ]
        ](
          colSlotCount
        )

      for colSlot in 0 ..< colSlotCount:
        disjointTable.table[rowSlot][colSlot] =
          newSeqWith(
            disjointTable.heightValue,
            newSeqWith(
              disjointTable.widthValue,
              CM.e(),
            ),
          )

    disjointTable.table[0][0] =
      values

    if disjointTable.heightValue == 0 or
        disjointTable.widthValue == 0:
      return

    for rowLevel in 0 ..< disjointTable.rowLevelCount:
      let rowSlot =
        rowLevel + 1

      let halfHeight =
        1 shl rowLevel

      let blockHeight =
        halfHeight shl 1

      var blockBegin =
        0

      while blockBegin < disjointTable.heightValue:
        let middle =
          min(
            blockBegin + halfHeight,
            disjointTable.heightValue,
          )

        let blockEnd =
          min(
            blockBegin + blockHeight,
            disjointTable.heightValue,
          )

        for col in 0 ..< disjointTable.widthValue:
          if middle > blockBegin:
            disjointTable.table[
              rowSlot
            ][
              0
            ][
              middle - 1
            ][
              col
            ] =
              values[
                middle - 1
              ][
                col
              ]

            if middle - 2 >= blockBegin:
              for row in countdown(
                  middle - 2,
                  blockBegin
              ):
                disjointTable.table[
                  rowSlot
                ][
                  0
                ][
                  row
                ][
                  col
                ] =
                  CM.op(
                    values[
                      row
                    ][
                      col
                    ],
                    disjointTable.table[
                      rowSlot
                    ][
                      0
                    ][
                      row + 1
                    ][
                      col
                    ],
                  )

          if middle < blockEnd:
            disjointTable.table[
              rowSlot
            ][
              0
            ][
              middle
            ][
              col
            ] =
              values[
                middle
              ][
                col
              ]

            for row in middle + 1 ..< blockEnd:
              disjointTable.table[
                rowSlot
              ][
                0
              ][
                row
              ][
                col
              ] =
                CM.op(
                  disjointTable.table[
                    rowSlot
                  ][
                    0
                  ][
                    row - 1
                  ][
                    col
                  ],
                  values[
                    row
                  ][
                    col
                  ],
                )

        blockBegin +=
          blockHeight

    for rowSlot in 0 ..< rowSlotCount:
      for colLevel in 0 ..< disjointTable.colLevelCount:
        let colSlot =
          colLevel + 1

        let halfWidth =
          1 shl colLevel

        let blockWidth =
          halfWidth shl 1

        var blockBegin =
          0

        while blockBegin < disjointTable.widthValue:
          let middle =
            min(
              blockBegin + halfWidth,
              disjointTable.widthValue,
            )

          let blockEnd =
            min(
              blockBegin + blockWidth,
              disjointTable.widthValue,
            )

          for row in 0 ..< disjointTable.heightValue:
            if middle > blockBegin:
              disjointTable.table[
                rowSlot
              ][
                colSlot
              ][
                row
              ][
                middle - 1
              ] =
                disjointTable.table[
                  rowSlot
                ][
                  0
                ][
                  row
                ][
                  middle - 1
                ]

              if middle - 2 >= blockBegin:
                for col in countdown(
                    middle - 2,
                    blockBegin
                ):
                  disjointTable.table[
                    rowSlot
                  ][
                    colSlot
                  ][
                    row
                  ][
                    col
                  ] =
                    CM.op(
                      disjointTable.table[
                        rowSlot
                      ][
                        0
                      ][
                        row
                      ][
                        col
                      ],
                      disjointTable.table[
                        rowSlot
                      ][
                        colSlot
                      ][
                        row
                      ][
                        col + 1
                      ],
                    )

            if middle < blockEnd:
              disjointTable.table[
                rowSlot
              ][
                colSlot
              ][
                row
              ][
                middle
              ] =
                disjointTable.table[
                  rowSlot
                ][
                  0
                ][
                  row
                ][
                  middle
                ]

              for col in middle + 1 ..< blockEnd:
                disjointTable.table[
                  rowSlot
                ][
                  colSlot
                ][
                  row
                ][
                  col
                ] =
                  CM.op(
                    disjointTable.table[
                      rowSlot
                    ][
                      colSlot
                    ][
                      row
                    ][
                      col - 1
                    ],
                    disjointTable.table[
                      rowSlot
                    ][
                      0
                    ][
                      row
                    ][
                      col
                    ],
                  )

          blockBegin +=
            blockWidth

  proc initDenseDisjointSparseTable2D*[
      CM: CommutativeMonoid
  ](
      height,
      width: int,
      _: typedesc[CM]
  ): DenseDisjointSparseTable2D[CM] =
    ## Constructs an identity-filled static H x W table.
    ##
    ## Rectangle queries combine one, two, or four
    ## pairwise-disjoint directional rectangles.
    ##
    ## CM must be associative and commutative.
    ## Idempotence is not required.

    doAssert height >= 0
    doAssert width >= 0

    result.heightValue =
      height

    result.widthValue =
      width

    let values =
      newSeqWith(
        height,
        newSeqWith(
          width,
          CM.e(),
        ),
      )

    result.buildLevels(
      values
    )

  proc initDenseDisjointSparseTable2D*[
      CM: CommutativeMonoid
  ](
      values:
        seq[
          seq[
            CM.value_type
          ]
        ],
      _: typedesc[CM]
  ): DenseDisjointSparseTable2D[CM] =
    ## Builds from values[row][col].
    ##
    ## A zero-row nested sequence implies logical width zero.
    ## Use the dimension constructor for a zero-height,
    ## positive-width table.

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
      disjointTable:
        DenseDisjointSparseTable2D[CM]
  ): int {.inline.} =
    disjointTable.heightValue

  proc width*[
      CM: CommutativeMonoid
  ](
      disjointTable:
        DenseDisjointSparseTable2D[CM]
  ): int {.inline.} =
    disjointTable.widthValue

  proc get*[
      CM: CommutativeMonoid
  ](
      disjointTable:
        DenseDisjointSparseTable2D[CM],
      row,
      col: int
  ): CM.value_type {.inline.} =
    doAssert 0 <= row
    doAssert row < disjointTable.heightValue
    doAssert 0 <= col
    doAssert col < disjointTable.widthValue

    disjointTable.table[0][0][row][col]

  proc prod*[
      CM: CommutativeMonoid
  ](
      disjointTable:
        DenseDisjointSparseTable2D[CM],
      rowBegin,
      rowEnd,
      colBegin,
      colEnd: int
  ): CM.value_type =
    ## Returns the product over:
    ##
    ## [rowBegin, rowEnd) x [colBegin, colEnd).
    ##
    ## The selected directional rectangles are disjoint,
    ## so idempotence is unnecessary.

    doAssert 0 <= rowBegin
    doAssert rowBegin <= rowEnd
    doAssert rowEnd <= disjointTable.heightValue
    doAssert 0 <= colBegin
    doAssert colBegin <= colEnd
    doAssert colEnd <= disjointTable.widthValue

    if rowBegin == rowEnd or
        colBegin == colEnd:
      return CM.e()

    let bottomRow =
      rowEnd - 1

    let rightCol =
      colEnd - 1

    let rowSlot =
      if rowBegin == bottomRow:
        0
      else:
        highestBitIndex(
          rowBegin xor bottomRow
        ) + 1

    let colSlot =
      if colBegin == rightCol:
        0
      else:
        highestBitIndex(
          colBegin xor rightCol
        ) + 1

    if rowSlot == 0 and
        colSlot == 0:
      return disjointTable.table[
        0
      ][
        0
      ][
        rowBegin
      ][
        colBegin
      ]

    if rowSlot == 0:
      return CM.op(
        disjointTable.table[
          0
        ][
          colSlot
        ][
          rowBegin
        ][
          colBegin
        ],
        disjointTable.table[
          0
        ][
          colSlot
        ][
          rowBegin
        ][
          rightCol
        ],
      )

    if colSlot == 0:
      return CM.op(
        disjointTable.table[
          rowSlot
        ][
          0
        ][
          rowBegin
        ][
          colBegin
        ],
        disjointTable.table[
          rowSlot
        ][
          0
        ][
          bottomRow
        ][
          colBegin
        ],
      )

    CM.op(
      CM.op(
        disjointTable.table[
          rowSlot
        ][
          colSlot
        ][
          rowBegin
        ][
          colBegin
        ],
        disjointTable.table[
          rowSlot
        ][
          colSlot
        ][
          rowBegin
        ][
          rightCol
        ],
      ),
      CM.op(
        disjointTable.table[
          rowSlot
        ][
          colSlot
        ][
          bottomRow
        ][
          colBegin
        ],
        disjointTable.table[
          rowSlot
        ][
          colSlot
        ][
          bottomRow
        ][
          rightCol
        ],
      ),
    )

  proc allProd*[
      CM: CommutativeMonoid
  ](
      disjointTable:
        DenseDisjointSparseTable2D[CM]
  ): CM.value_type {.inline.} =
    disjointTable.prod(
      0,
      disjointTable.heightValue,
      0,
      disjointTable.widthValue,
    )

  proc `[]`*[
      CM: CommutativeMonoid
  ](
      disjointTable:
        DenseDisjointSparseTable2D[CM],
      row,
      col: int
  ): CM.value_type {.inline.} =
    disjointTable.get(
      row,
      col,
    )
