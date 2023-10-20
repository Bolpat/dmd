/+ TEST_OUTPUT:
---
fail_compilation/fail21243.d(1): Error: found `(` when expecting `ref` and function literal following `auto`
fail_compilation/fail21243.d(1): Error: semicolon expected following auto declaration, not `int`
fail_compilation/fail21243.d(1): Error: semicolon needed to end declaration of `x` instead of `)`
fail_compilation/fail21243.d(1): Error: declaration expected, not `)`
fail_compilation/fail21243.d(2): Error: `auto` can only be used as part of `auto ref` for function literal return values
fail_compilation/fail21243.d(3): Error: basic type expected, not `(`
fail_compilation/fail21243.d(3): Error: function declaration without return type. (Note that constructors are always named `this`)
fail_compilation/fail21243.d(3): Deprecation: storage class `auto` has no effect in type aliases
fail_compilation/fail21243.d(3): Error: semicolon expected to close `alias` declaration, not `=>`
fail_compilation/fail21243.d(3): Error: declaration expected, not `=>`
fail_compilation/fail21243.d(4): Error: `auto` can only be used as part of `auto ref` for function literal return values
---
+/
#line 1
auto a = auto (int x) => x;
auto b = function auto (int x) { return x; };
alias c = auto (int x) => x;
alias d = function auto (int x) { return x; };
