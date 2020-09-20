#include <doctest/doctest.h>

#include <sample/public.hpp>
#include <sample/public_header_only.hpp>

TEST_CASE("sample::add works correctly") { CHECK(sample::add(40, 2) == 42); }

TEST_CASE("sample::mul works correctly") { CHECK(sample::mul(21, 2) == 42); }
