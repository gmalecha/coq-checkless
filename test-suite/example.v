Require Import String.
Add Rec LoadPath "../src/" as Timing.
Add ML Path "../src/".
Declare ML Module "checkless".

Goal true = true.
  Time exact_no_check (@eq_refl bool true).
Qed.

Fixpoint fact (n : nat) : nat :=
  match n with
    | 0 => 1
    | S n => 2 * (fact n)
  end.

Fixpoint rfact (n : nat) : nat :=
  match n with
    | 0 => 1
    | S n => rfact n * 2
  end.

Goal 1 = 2.
  exact_no_check (@eq_refl nat 1).
Abort.

(** A note on unification variables **)
Goal exists x : nat, fst (1,x) = 1.
eexists.
(** vm_casts will fail if unification variables are
 ** *syntactically* apparent in the term. e.g.
 **
 ** let V := match goal with
 **           | |- ?X => X
 **         end
 ** in
 ** exact_no_check (@eq_refl nat 1 <: V).
 **)
(* but they will succeed if the unification variables
 * are hidden by [let] declarations
 *)
match goal with
  | |- context [ (_, ?X) ] =>
    remember X
end.
exact_no_check (@eq_refl nat 1 <: fst (1, n) = 1).
Grab Existential Variables.
exact 1.
Qed.

Definition ident (T : Type) (t : T) : T := t.

(** to get around this, we have an unsafe way to build a vm_cast.
 ** the parsing rules of coq allow us to inject this into terms.
 **)
Goal exists x : nat, fst (1,x) = 1.
eexists.
match goal with
  | |- ?X =>
    unchecked_vm_cast (@eq_refl nat 1) X (fun Z => exact_no_check (ident (1=1) Z))
end.
Grab Existential Variables.
exact 1.
Qed.

Goal True.
idtac;
let F x := pose x in
unchecked_change (1+1) 3 (1+1 = 3) F.
trivial.
Qed.