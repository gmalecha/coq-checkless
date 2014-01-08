(*i camlp4deps: "parsing/grammar.cma" i*)
(*i camlp4use: "pa_extend.cmp" i*)

(** Call ltac (taken from coq-plugin-utils,
 **            in turn taken from Thomas Braibant)
 ** This is temporary because I'm not sure the best way to put dependencies
 ** between different plugins
 **)
let ltac_call tac (args:Tacexpr.glob_tactic_arg list) =
  Tacexpr.TacArg(Util.dummy_loc,Tacexpr.TacCall(Util.dummy_loc, Glob_term.ArgArg(Util.dummy_loc, Lazy.force tac),args))

(* Calling a locally bound tactic *)
let ltac_lcall tac args =
  Tacexpr.TacArg(Util.dummy_loc,Tacexpr.TacCall(Util.dummy_loc, Glob_term.ArgVar(Util.dummy_loc, Names.id_of_string tac),args))

let ltac_letin (x, e1) e2 =
  Tacexpr.TacLetIn(false,[(Util.dummy_loc,Names.id_of_string x),e1],e2)

let ltac_apply (f:Tacexpr.glob_tactic_expr) (args:Tacexpr.glob_tactic_arg list) =
  Tacinterp.eval_tactic
    (ltac_letin ("F", Tacexpr.Tacexp f) (ltac_lcall "F" args))

let to_ltac_val c = Tacexpr.TacDynamic(Util.dummy_loc,Pretyping.constr_in c)




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

TACTIC EXTEND unchecked_change
  | [ "unchecked_change" constr(from) constr(into) constr(trm) tactic(cont) ] ->
    [ fun gl ->
        let ntrm = Termops.replace_term from into trm in
	ltac_apply cont [to_ltac_val ntrm] gl
    ]
END;;

TACTIC EXTEND unchecked_vm_cast
  | [ "unchecked_vm_cast" constr(l) constr(r) tactic(cont) ] ->
    [ fun gl ->
      let result = Term.mkCast (l, Term.VMcast, r) in
      ltac_apply cont [to_ltac_val result] gl
    ]
END;;
