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
 ** match goal with
 **   | |- ?G =>
 **     exact_no_check (@eq_refl nat 1 <: G)
 ** end.
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
