#pragma once

#include <string>

enum SignalState { Zero = 0, One = 1, X = 2 };

inline std::string to_string(SignalState state) {
  if (state == SignalState::Zero) {
    return "0";
  } else if (state == SignalState::One) {
    return "1";
  } else {
    return "X";
  }
}
