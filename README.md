QUnit-TAP-GCC
=============

A stub to test Javascript code compiled with [Google Closure Compiler](https://developers.google.com/closure/compiler/) in ADVANCED\_OPTIMIZATION mode on [QUnit](https://github.com/jquery/qunit) and [QUnit-TAP](https://github.com/twada/qunit-tap).

It uses the tweaked versions of QUnit ([mootoh/qunit](https://github.com/mootoh/qunit)) and QUnit-TAP ([mootoh/qunit-tap](https://github.com/mootoh/qunit-tap)).

USAGE
-------------

Download required stuff:

    % make setup

And run a sample:

    % make

Result:

    % make
    cat lib/qunit.js lib/qunit-tap.js build/original.js > build/original_test.js
    prove --exec=node build/original_test.js
    build/original_test.js .. ok
    All tests successful.
    Files=1, Tests=1,  0 wallclock secs ( 0.03 usr  0.02 sys +  0.06 cusr  0.02 csys =  0.13 CPU)
    Result: PASS
    cat lib/qunit.js lib/qunit-tap.js build/compiled.js > build/compiled_test.js
    prove --exec=node build/compiled_test.js
    build/compiled_test.js .. ok
    All tests successful.
    Files=1, Tests=1,  0 wallclock secs ( 0.02 usr  0.01 sys +  0.04 cusr  0.00 csys =  0.07 CPU)
    Result: PASS

LICENSE
-------------
MIT.
