when not declared ATCODER_EXTRA_STRUCTURE_OFFLINE_POINT_ADD_RECTANGLE_SUM_HPP:
  const ATCODER_EXTRA_STRUCTURE_OFFLINE_POINT_ADD_RECTANGLE_SUM_HPP* = 1

  import std/algorithm
  import std/sequtils

  type
    OfflinePointAddRectangleSumEventKind =
      enum
        pointAddEvent,
        rectangleQueryEvent

    OfflinePointAddRectangleSumEvent[S] =
      object
        case kind:
          OfflinePointAddRectangleSumEventKind
        of pointAddEvent:
          x:
            int
          y:
            int
          weight:
            S
        of rectangleQueryEvent:
          xBegin:
            int
          xEnd:
            int
          yBegin:
            int
          yEnd:
            int
          queryIndex:
            int

    OfflinePointAddRectangleSum*[S; Ops] =
      object
        initialPoints:
          seq[
            tuple[
              x:
                int,
              y:
                int,
              weight:
                S
            ]
          ]
        events:
          seq[
            OfflinePointAddRectangleSumEvent[
              S
            ]
          ]
        queryCountValue:
          int

  proc sortedUnique(
      values:
        var seq[
          int
        ]
  ): seq[int] =
    values.sort()

    for value in values:
      if result.len == 0 or
          result[^1] != value:
        result.add(
          value
        )

  proc fenwickPointAdd[
      S;
      Ops
  ](
      xCoordinates:
        seq[
          int
        ],
      yCoordinates:
        seq[
          seq[
            int
          ]
        ],
      values:
        var seq[
          seq[
            S
          ]
        ],
      x,
      y:
        int,
      weight:
        S
  ) =
    mixin add

    var xIndex =
      lowerBound(
        xCoordinates,
        x,
      ) + 1

    while xIndex <=
        xCoordinates.len:
      var yIndex =
        lowerBound(
          yCoordinates[
            xIndex
          ],
          y,
        ) + 1

      while yIndex <
          values[
            xIndex
          ].len:
        values[
          xIndex
        ][
          yIndex
        ] =
          add(
            Ops,
            values[
              xIndex
            ][
              yIndex
            ],
            weight,
          )

        yIndex +=
          yIndex and -yIndex

      xIndex +=
        xIndex and -xIndex

  proc fenwickPrefixSum[
      S;
      Ops
  ](
      xCoordinates:
        seq[
          int
        ],
      yCoordinates:
        seq[
          seq[
            int
          ]
        ],
      values:
        seq[
          seq[
            S
          ]
        ],
      xEnd,
      yEnd:
        int
  ): S =
    mixin zero, add

    result =
      zero(
        Ops
      )

    var xIndex =
      lowerBound(
        xCoordinates,
        xEnd,
      )

    while xIndex > 0:
      var yIndex =
        lowerBound(
          yCoordinates[
            xIndex
          ],
          yEnd,
        )

      while yIndex > 0:
        result =
          add(
            Ops,
            result,
            values[
              xIndex
            ][
              yIndex
            ],
          )

        yIndex -=
          yIndex and -yIndex

      xIndex -=
        xIndex and -xIndex

  proc initOfflinePointAddRectangleSum*[
      S;
      Ops
  ](
      initialPoints:
        seq[
          tuple[
            x:
              int,
            y:
              int,
            weight:
              S
          ]
        ],
      _:
        typedesc[
          Ops
        ]
  ): OfflinePointAddRectangleSum[
      S,
      Ops
  ] =
    ## Constructs an offline point-add and rectangle-sum
    ## event solver.
    ##
    ## Initial points are active before the first event.
    ##
    ## Ops must provide zero, add, and sub.

    result.initialPoints =
      newSeq[
        tuple[
          x:
            int,
          y:
            int,
          weight:
            S
        ]
      ](
        initialPoints.len
      )

    for index in 0 ..<
        initialPoints.len:
      result.initialPoints[
        index
      ] =
        initialPoints[
          index
        ]

  proc addPoint*[
      S;
      Ops
  ](
      solver:
        var OfflinePointAddRectangleSum[
          S,
          Ops
        ],
      x,
      y:
        int,
      weight:
        S
  ) =
    solver.events.add(
      OfflinePointAddRectangleSumEvent[
        S
      ](
        kind:
          pointAddEvent,
        x:
          x,
        y:
          y,
        weight:
          weight,
      )
    )

  proc addRectangleQuery*[
      S;
      Ops
  ](
      solver:
        var OfflinePointAddRectangleSum[
          S,
          Ops
        ],
      xBegin,
      xEnd,
      yBegin,
      yEnd:
        int
  ): int =
    doAssert xBegin <= xEnd
    doAssert yBegin <= yEnd

    result =
      solver.queryCountValue

    solver.queryCountValue.inc

    solver.events.add(
      OfflinePointAddRectangleSumEvent[
        S
      ](
        kind:
          rectangleQueryEvent,
        xBegin:
          xBegin,
        xEnd:
          xEnd,
        yBegin:
          yBegin,
        yEnd:
          yEnd,
        queryIndex:
          result,
      )
    )

  proc queryCount*[
      S;
      Ops
  ](
      solver:
        OfflinePointAddRectangleSum[
          S,
          Ops
        ]
  ): int {.inline.} =
    solver.queryCountValue

  proc solve*[
      S;
      Ops
  ](
      solver:
        OfflinePointAddRectangleSum[
          S,
          Ops
        ]
  ): seq[S] =
    ## Returns answers in query-registration order.
    ##
    ## Each query observes the initial points and only
    ## point-add events registered before that query.
    ##
    ## solve is repeatable and does not mutate events.

    mixin zero, add, sub

    result =
      newSeqWith(
        solver.queryCountValue,
        zero(
          Ops
        ),
      )

    var updateCoordinates =
      newSeq[
        tuple[
          x:
            int,
          y:
            int
        ]
      ]()

    for point in solver.initialPoints:
      updateCoordinates.add(
        (
          x:
            point.x,
          y:
            point.y,
        )
      )

    for event in solver.events:
      if event.kind ==
          pointAddEvent:
        updateCoordinates.add(
          (
            x:
              event.x,
            y:
              event.y,
          )
        )

    var xBuffer =
      newSeq[int](
        updateCoordinates.len
      )

    for index in 0 ..<
        updateCoordinates.len:
      xBuffer[
        index
      ] =
        updateCoordinates[
          index
        ].x

    let xCoordinates =
      sortedUnique(
        xBuffer
      )

    var yCoordinates =
      newSeq[
        seq[
          int
        ]
      ](
        xCoordinates.len + 1
      )

    for coordinate in updateCoordinates:
      var xIndex =
        lowerBound(
          xCoordinates,
          coordinate.x,
        ) + 1

      while xIndex <=
          xCoordinates.len:
        yCoordinates[
          xIndex
        ].add(
          coordinate.y
        )

        xIndex +=
          xIndex and -xIndex

    for xIndex in 1 ..<
        yCoordinates.len:
      yCoordinates[
        xIndex
      ] =
        sortedUnique(
          yCoordinates[
            xIndex
          ]
        )

    var fenwickValues =
      newSeq[
        seq[
          S
        ]
      ](
        xCoordinates.len + 1
      )

    for xIndex in 1 ..<
        fenwickValues.len:
      fenwickValues[
        xIndex
      ] =
        newSeqWith(
          yCoordinates[
            xIndex
          ].len + 1,
          zero(
            Ops
          ),
        )

    for point in solver.initialPoints:
      fenwickPointAdd[
        S,
        Ops
      ](
        xCoordinates,
        yCoordinates,
        fenwickValues,
        point.x,
        point.y,
        point.weight,
      )

    for event in solver.events:
      case event.kind
      of pointAddEvent:
        fenwickPointAdd[
          S,
          Ops
        ](
          xCoordinates,
          yCoordinates,
          fenwickValues,
          event.x,
          event.y,
          event.weight,
        )

      of rectangleQueryEvent:
        let upperStrip =
          sub(
            Ops,
            fenwickPrefixSum[
              S,
              Ops
            ](
              xCoordinates,
              yCoordinates,
              fenwickValues,
              event.xEnd,
              event.yEnd,
            ),
            fenwickPrefixSum[
              S,
              Ops
            ](
              xCoordinates,
              yCoordinates,
              fenwickValues,
              event.xBegin,
              event.yEnd,
            ),
          )

        let lowerStrip =
          sub(
            Ops,
            fenwickPrefixSum[
              S,
              Ops
            ](
              xCoordinates,
              yCoordinates,
              fenwickValues,
              event.xEnd,
              event.yBegin,
            ),
            fenwickPrefixSum[
              S,
              Ops
            ](
              xCoordinates,
              yCoordinates,
              fenwickValues,
              event.xBegin,
              event.yBegin,
            ),
          )

        result[
          event.queryIndex
        ] =
          sub(
            Ops,
            upperStrip,
            lowerStrip,
          )
