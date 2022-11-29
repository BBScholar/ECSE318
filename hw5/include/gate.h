#pragma once

#include <cstdint>
#include <iostream>
#include <optional>
#include <string>
#include <string_view>
#include <type_traits>
#include <vector>

typedef uint32_t GateId;

namespace GateType {
enum GateType : uint8_t { Input = 0, Output, Not, Dff, Or, Nor, And, Nand };
}

inline uint32_t gate_num_inputs(GateType::GateType type) {
  switch (type) {
  case GateType::And:
  case GateType::Nand:
  case GateType::Or:
  case GateType::Nor:
    return 2;
  case GateType::Dff:
  case GateType::Not:
    return 1;
  default:
    return 0; // ignore input and output becayse we won't use this function for
              // those gate types
  }
}

inline std::optional<GateType::GateType>
gate_type_from_string(std::string_view s) {
  if (s == "input") {
    return std::optional<GateType::GateType>(GateType::Input);
  } else if (s == "output") {
    return std::optional<GateType::GateType>(GateType::Output);
  } else if (s == "dff1" || s == "dff") {
    return std::optional<GateType::GateType>(GateType::Dff);
  } else if (s == "not") {
    return std::optional<GateType::GateType>(GateType::Not);
  } else if (s == "and") {
    return std::optional<GateType::GateType>(GateType::And);
  } else if (s == "nand") {
    return std::optional<GateType::GateType>(GateType::Nand);
  } else if (s == "or") {
    return std::optional<GateType::GateType>(GateType::Or);
  } else if (s == "nor") {
    return std::optional<GateType::GateType>(GateType::Nor);
  } else {
    return std::nullopt;
  }
}

enum SignalState : uint8_t { Zero = 0, One = 1, X = 2 };

inline char signal_state_to_char(SignalState sig) {
  switch (sig) {
  case SignalState::Zero:
    return '0';
  case SignalState::One:
    return '1';
  default:
  case SignalState::X:
    return '4';
  }
}

inline SignalState signal_state_from_char(char c) {
  switch (c) {
  case '0':
    return SignalState::Zero;
  case '1':
    return SignalState::One;
  default:
    std::cerr << "Invalid character (" << c
              << ") in input. Interpretting as 'X' instead." << std::endl;
  case '4':
    return SignalState::X;
  }
}

class Gate {
public:
  Gate(const std::string &name, GateId id, GateType::GateType type,
       uint32_t level = 0);
  ~Gate() = default;

  inline GateId get_id() const { return m_id; }
  inline GateType::GateType get_type() const { return m_type; }
  inline SignalState get_state() const { return m_state; }
  inline const std::string &get_name() const { return m_name; }
  inline uint32_t get_level() const { return m_level; }

  inline void set_level(uint32_t level) { m_level = level; }
  inline void set_state(SignalState sig) { m_state = sig; }

  inline void add_input_gate(GateId id) { m_fan_in.push_back(id); }
  inline void add_output_gate(GateId id) { m_fan_out.push_back(id); }

  std::vector<GateId> &get_fan_in() { return m_fan_in; }
  std::vector<GateId> &get_fan_out() { return m_fan_out; }

  std::string to_string();

private:
  std::string m_name;
  GateId m_id;
  GateType::GateType m_type;
  uint32_t m_level;

  SignalState m_state;

  std::vector<GateId> m_fan_in, m_fan_out;
};

// std::vector<GateId> get_top_ordering();
