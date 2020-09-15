#include <gtest/gtest.h>

#include "sample2.hpp"

TEST(SampleUnitTest, SubFortyByTwo) {
    EXPECT_EQ(sample::internal::sub(40, 2), 38);
}
