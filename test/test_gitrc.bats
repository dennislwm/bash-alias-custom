setup() {
  load test_helper/bats-file/load
}

function test_file_exists { #@test
  assert_exists src/gitrc.sh
}