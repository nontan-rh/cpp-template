#include <sample.hpp>

#include "sample2.hpp"

namespace sample {

int add(int a, int b) { return internal::sub(a, -b); }

} // namespace sample
