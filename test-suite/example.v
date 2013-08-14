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

Eval lazy in fact 12.

Goal fact 12 = rfact 12.
  Time exact_no_check (@eq_refl nat 4096).
Time Qed.