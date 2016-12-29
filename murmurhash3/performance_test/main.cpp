#include <iostream>
#include <iomanip>

#include "murmur3.h"

int main() {
    for (uint32_t i = 0; i < 0x1000000; ++i) {
        uint32_t h = murmur3_32(&i, 1, 0);
        std::cout
            << std::dec
            << i
            << ' '
            << std::hex
            << h
            << std::endl;
    }

    return 0;
}
