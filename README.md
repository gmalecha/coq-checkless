coq-checkless
=============

A Coq plugin that exposes [refine_no_check] which performs refine with
a term but does not type check the result immediately. Soundness is
still guaranteed because [Qed] or [Defined] will check the proof.

This plugin has beem compiled succesfully with Coq 8.4-pl2

Installation
=================

make
make install

Usage
=================

The plugin exposes a single new tactic [exact_no_check].

- [exact_no_check t] is identical to [exact t] except
  there is no checking done of the term. This means that
  you *must* include all implicit arguments.