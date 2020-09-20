#include <sample/public.hpp>

#include "internal.hpp"

namespace sample {

int add(int a, int b) { return internal::sub(a, -b); }

} // namespace sample
