#pragma once

#include <cinttypes>

#include "gate.h"

namespace lut {

constexpr uint32_t gate_type_to_lut_index(GateType::GateType type) {
  switch (type) {
  case GateType::And:
    return 0;
  case GateType::Nand:
    return 1;
  case GateType::Or:
    return 2;
  case GateType::Nor:
    return 3;
  default:
    return 4; // cause segfault
  }
}

// AND, NAND, OR, NOR
constexpr uint8_t k_c_input[4] = {0, 0, 1, 1};
constexpr uint8_t k_i_input[4] = {0, 1, 0, 1};

// constexpr uint8_t k_and_table[3][3] = {{0, 0, 2}, {0, 1, 2}, {2, 2, 2}};
// constexpr uint8_t k_nand_table[3][3] = {{1, 1, 2}, {1, 0, 2}, {2, 2, 2}};
// constexpr uint8_t k_or_table[3][3] = {{0, 1, 2}, {1, 1, 2}, {2, 2, 2}};
// constexpr uint8_t k_nor_table[3][3] = {{1, 0, 2}, {0, 0, 2}, {2, 2, 2}};

constexpr uint8_t k_inv_table[3] = {1, 0, 2};
constexpr uint8_t k_buf_table[3] = {0, 1, 2};
// constexpr uint8_t k_table[4][3][3] = {
//     {{0, 0, 2}, {0, 1, 2}, {2, 2, 2}}, // and
//     {{1, 1, 2}, {1, 0, 2}, {2, 2, 2}}, // nand
//     {{0, 1, 2}, {1, 1, 2}, {2, 2, 2}}, // or
//     {{1, 0, 2}, {0, 0, 2}, {2, 2, 2}}, // nor
// };
// constexpr uint8_t k_table[4][3][3] = {
//     {{0, 0, 2}, {0, 1, 2}, {2, 2, 2}}, // and
//     {{0, 0, 2}, {0, 1, 2}, {2, 2, 2}}, // and
//     {{0, 1, 2}, {1, 1, 2}, {2, 2, 2}}, // or
//     {{0, 1, 2}, {1, 1, 2}, {2, 2, 2}}  // or
// };
constexpr uint8_t k_table[4][3][3] = {
    {{0, 0, 0}, {0, 1, 2}, {0, 2, 2}}, // and
    {{0, 0, 0}, {0, 1, 2}, {0, 2, 2}}, // and
    {{0, 1, 2}, {1, 1, 1}, {2, 1, 2}}, // or
    {{0, 1, 2}, {1, 1, 1}, {2, 1, 2}}, // or
};

} // namespace lut
