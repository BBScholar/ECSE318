#pragma once

#include "gate.h"

constexpr uint32_t signal_state_to_lut_index(SignalState s) {
  switch (s) {
  case SignalState::Zero:
    return 0;
  case SignalState::One:
    return 1;
  case SignalState::X:
    return 2;
  }
}

constexpr uint32_t gate_type_to_lut_index(GateType::GateType type) {}

constexpr SignalState k_inv_table[3] = {SignalState::One, SignalState::Zero,
                                        SignalState::X};
constexpr SignalState k_buf_table[3] = {SignalState::Zero, SignalState::One,
                                        SignalState::X};

constexpr SignalState k_c_input[4] = {SignalState::Zero, SignalState::One,
                                      SignalState::Zero, SignalState::One};
constexpr SignalState k_i_input[4] = {SignalState::Zero, SignalState::Zero,
                                      SignalState::One, SignalState::One};

// constexpr SignalState k_table[4][3][3];
constexpr SignalState k_and_table[3][3] = {{}, {}, {}};
