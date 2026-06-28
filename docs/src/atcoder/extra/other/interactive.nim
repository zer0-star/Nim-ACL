when not declared ATCODER_INTERACTIVE_HPP:
  const ATCODER_INTERACTIVE_HPP* = 1
  import std/macros, std/strformat

  macro solveInteractive*(head, body:untyped) =
    var solveProcBody = newStmtList()
    solveProcBody.add parseStmt("when DO_TEST: (var outputString:string;var fd_pipe: array[2, cint];discard pipe(fd_pipe);discard close(cint(0));discard dup2(fd_pipe[0], cint(0));discard close(fd_pipe[0]);fd_pipe[0] = cint(0))")
    solveProcBody.add parseStmt "when DO_TEST:\n  proc addStdin(s:string) = (var s = s.cstring; discard(write(fd_pipe[1], s, s.len + 1)))"
    solveProcBody.add parseStmt "when DO_TEST:\n  proc judgeEcho(x:varargs[string, `$`]) = (addStdin(x.join() & \"\\n\");echo \" \".repeat(20), x.join())"
    solveProcBody.add parseStmt "proc askEcho(x:varargs[string, `$`]) = (let s = x.join() & \"\\n\"; when DO_TEST: outputString.add(s);stdout.write s;flushFile(stdout);)"

    proc dfs(body:NimNode):NimNode =
      result = newStmtList()
      for a in body:
        if a.kind == nnkIdent: result.add a
        elif a.kind == nnkCall:
          if $a[0] == "Judge":
            var tmp = newStmtList()
            if a.len == 2:
              tmp.add(a[1])
            elif a.len == 3:
              tmp.add(parseStmt(fmt"var {a[1].repr} = newStringStream(outputString)"))
              tmp.add(a[2])
              tmp.add(parseStmt("outputString = \"\""))
            else:
              doAssert false
            result.add(newNimNode(nnkWhenStmt).add(
              newNimNode(nnkElifBranch).add(ident"DO_TEST").add(tmp)
            ))
          else: result.add(a)
        elif a.kind == nnkProcDef:
          a[6] = dfs(a[6])
          result.add(a)
        elif a.kind == nnkBlockStmt:
          a[1] = dfs(a[1])
          result.add(a)
        elif a.kind == nnkIfStmt:
          for i in 0..<a.len:
            a[i][^1] = dfs(a[i][^1])
          result.add(a)
        else:
          result.add(a)
    solveProcBody.add dfs(body)
    result = newStmtList()
    result.add parseStmt("when DO_TEST: import posix, strutils, streams")
    var procDef = newStmtList()
    var params = @[ident"auto"]
    for i in 1..<head.len:
      var identDefs = newNimNode(nnkIdentDefs)
      identDefs.add(head[i][0]).add(head[i][1]).add(newEmptyNode())
      params.add identDefs
    procDef.add newNimNode(nnkWhenStmt).add(
      newNimNode(nnkElifBranch).add(ident"DO_TEST").add(
        newProc(name = head[0], params = params, body = solveProcBody))).add(
      newNimNode(nnkElse).add(
        newProc(name = head[0], params = @[ident"auto"], body = solveProcBody))
      )
    result.add procDef
    #echo result.repr
