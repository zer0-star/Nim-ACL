# set_map

`set_map` is a compatibility alias module.

For new code, prefer [`sorted_set_map`](./sorted_set_map.html).

## Import

~~~nim
import atcoder/extra/structure/set_map
~~~

## Definition

~~~nim
import atcoder/extra/structure/sorted_set_map
export sorted_set_map
~~~

This module imports and exports `sorted_set_map`.  
Therefore, importing `set_map` also makes `SortedSet`, `SortedMap`, `initSortedSet`, `initSortedMap`, and related APIs available.

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/structure/set_map

var s = initSortedSet[int]()

s.insert(3)
s.insert(1)

doAssert 1 in s
doAssert 2 notin s
~~~

## Notes

This module remains for compatibility with older code.  
For new code, use:

~~~nim
import atcoder/extra/structure/sorted_set_map
~~~
