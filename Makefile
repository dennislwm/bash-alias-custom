.PHONY: default bats-helper bats-test

default: bats-test

bats-helper:
	if [ -d "test/test_helper/bats-assert" ]; then cd test/test_helper/bats-assert && git pull; else git clone https://github.com/bats-core/bats-assert.git test/test_helper/bats-assert; fi
	if [ -d "test/test_helper/bats-file" ]; then cd test/test_helper/bats-file && git pull; else git clone https://github.com/bats-core/bats-file.git test/test_helper/bats-file; fi

bats-test:
	bats test