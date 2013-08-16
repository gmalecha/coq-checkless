(*i camlp4deps: "parsing/grammar.cma" i*)
(*i camlp4use: "pa_extend.cmp" i*)

TACTIC EXTEND exact_no_check
  | ["exact_no_check" constr(n)] ->
    [Tactics.exact_no_check n
    ]
END;;

TACTIC EXTEND vm_compute_no_check
  | ["vm_compute_no_check" constr(n)] ->
    [Tactics.vm_cast_no_check n
    ]
END;;
