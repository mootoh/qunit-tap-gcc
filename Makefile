test: test_original test_compiled

BUILDDIR=build
LIBDIR=lib

ORIGINAL=$(BUILDDIR)/original.js
COMPILED=$(BUILDDIR)/compiled.js
QUNITS=$(LIBDIR)/qunit.js $(LIBDIR)/qunit-tap.js
ORIGINAL_TEST=$(BUILDDIR)/original_test.js
COMPILED_TEST=$(BUILDDIR)/compiled_test.js

setup:
	mkdir -p $(BUILDDIR) $(LIBDIR)
	cd $(LIBDIR); \
	curl -O https://raw.github.com/mootoh/qunit/closure_compiler_and_nodejs/qunit/qunit.js; \
	curl -O https://raw.github.com/mootoh/qunit-tap/closure_compiler_and_nodejs/lib/qunit-tap.js; \
	curl -O https://raw.github.com/mootoh/qunit-tap/closure_compiler_and_nodejs/qunit-tap_extern.js; \
	curl -O https://raw.github.com/mootoh/qunit/closure_compiler_and_nodejs/addons/qunit_extern.js; \
	curl -O http://closure-compiler.googlecode.com/files/compiler-latest.zip; \
	unzip compiler-latest.zip

$(ORIGINAL):test.js main.js
	mkdir -p $(BUILDDIR)
	cat $^ > $@

original: $(ORIGINAL)

$(ORIGINAL_TEST): original
	cat $(QUNITS) $(ORIGINAL) > $@

test_original: $(ORIGINAL_TEST)
	prove --exec=node $(ORIGINAL_TEST)

JGCC=java -jar $(LIBDIR)/compiler.jar
JGCC_FLAGS=\
	--compilation_level ADVANCED_OPTIMIZATIONS \
	--jscomp_off=nonStandardJsDocs \
	--jscomp_off=globalThis \
	--property_map_output_file $(BUILDDIR)/props.map \
	--variable_map_output_file $(BUILDDIR)/vars.map \
	--externs $(LIBDIR)/qunit_extern.js --externs $(LIBDIR)/qunit-tap_extern.js

$(COMPILED): $(ORIGINAL)
	$(JGCC) $(JGCC_FLAGS) $< --js_output_file $@

compile: $(COMPILED)

$(COMPILED_TEST): compile
	cat $(QUNITS) $(COMPILED) > $@

test_compiled: $(COMPILED_TEST)
	prove --exec=node $(COMPILED_TEST)

clean:
	rm -fr $(BUILDDIR)
