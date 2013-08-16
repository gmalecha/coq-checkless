coq-checkless
=============

A Coq plugin that exposes [refine_no_check] which performs refine with
a term but does not type check the result immediately. Soundness is
still guaranteed because [Qed] or [Defined] will check the proof.

This plugin has beem compiled succesfully with Coq 8.4-pl2

Installation
=================

```shell
make
make install
```

Usage
=================

To use the plugin (after installation), you can do the following.

```coq
Require Import Checkless.
```

The plugin exposes 2 tactics.

- [exact_no_check t] is identical to [exact t] except
  there is minimal checking done on the term. You should 
  include all implicit arguments.
- [vm_cast_no_check t] performs a cast of the current
  goal to [t] (using [vm_cast]). The conversion check
  is *not* performed.

Special Note on [vm_compute] and vm casts
=========================================

Since unification variables are not part of Coq's logic the kernel
does not support them. Since the reduction for vm_compute is done in
the kernel this means that you can not [vm_compute] on terms that
have unfication variables.

The above tactics work around this restriction with 1 caveat. They
still (seem to) perform shallow syntactic checks to ensure that
unification variables are not passed to vm casts. You can get around
this by introducing [let] declarations for unification variables.
See test-suite/examples.v for a example of how to do this.
