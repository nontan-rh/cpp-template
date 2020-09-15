#include <gtest/gtest.h>

#include <sample.hpp>

TEST(SampleIntegrationTest, AddFortyAndTwo) {
    EXPECT_EQ(sample::add(40, 2), 42);
}
