#include <doctest/doctest.h>

#include <sample/public.hpp>

#include "internal.hpp"

namespace sample {
namespace internal {

int sub(int a, int b) { return a - b; }

TEST_CASE("sample::internal::sub works correctly") {
    CHECK(sample::internal::sub(40, 2) == 38);
}

} // namespace internal
} // namespace sample
