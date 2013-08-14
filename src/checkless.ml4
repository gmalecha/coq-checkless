(*i camlp4deps: "parsing/grammar.cma" i*)
(*i camlp4use: "pa_extend.cmp" i*)

TACTIC EXTEND build_with
  | ["exact_no_check" constr(n)] ->
    [Tactics.exact_no_check n
    ]
END;;
