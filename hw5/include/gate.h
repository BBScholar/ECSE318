#pragma once

#include <cstdint>
#include <optional>
#include <string>
#include <string_view>
#include <type_traits>
#include <vector>

typedef uint32_t GateId;

namespace GateType {
enum GateType : uint8_t { Input = 0, Output, Not, Dff, Or, Nor, And, Nand };
}

enum class SignalState : uint8_t { Zero = 0, One = 1, X = 2 };

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
  } else if (s == "dff1") {
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

// inline std::string gate_type_to_string(GateType type) {
//   switch (type) {
//   case Input:
//     return "input";
//   case Output:
//     return "output";
//   case Dff:
//     return "dff1";
//   case Not:
//     return "not"
//   case
//   }
// }

class Gate {
public:
  Gate(const std::string &name, GateId id, GateType::GateType type,
       uint32_t level = 0);
  ~Gate() = default;

  inline GateId get_id() const { return m_id; }
  inline GateType::GateType get_type() const { return m_type; }
  inline SignalState get_state() const { return m_state; }

  inline void add_input_gate(GateId id) { m_fan_in.push_back(id); }
  inline void add_output_gate(GateId id) { m_fan_out.push_back(id); }

  const std::vector<GateId> &get_fan_in() { return m_fan_in; }
  const std::vector<GateId> &get_fan_out() { return m_fan_out; }

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
