#ifndef CPP_TEMPLATE_TEST_HOSTED_HPP
#define CPP_TEMPLATE_TEST_HOSTED_HPP

#include <string>

#include <gtest/gtest.h>

namespace cpp_template {
namespace test {
namespace hosted {

void initialize(int argc, char **argv);
int get_num_test_suites();
std::string get_test_suite_name(int test_suite_index);
int get_num_test_cases(int test_suite_index);
std::string get_test_case_name(int test_suite_index, int test_case_index);
int run_all_tests(::testing::TestEventListener &test_event_listener);

} // namespace hosted
} // namespace test
} // namespace cpp_template

#endif
