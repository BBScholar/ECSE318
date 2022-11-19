#include "gate.h"

#include <cstdint>
#include <sstream>

void Gate::set_state(SignalState state) { m_state = state; }
SignalState Gate::get_state() const { return m_state; }
Gate::GateType Gate::get_type() const { return m_type; }
const std::string &Gate::get_name() const { return m_name; }
const std::vector<Gate::GateId> &Gate::get_fan_out() const { return m_fan_out; }
const std::vector<Gate::GateId> &Gate::get_fan_in() const { return m_fan_in; };

std::optional<Gate> Gate::from_string(const std::string &s) {
  // something

  // std::sscanf(s.c_str(), "%0d %0d %0d %0d");
  return {};
}

std::string Gate::to_string() {
  std::stringstream ss;

  const uint8_t output = (uint8_t)(m_type == GateType::Output);

  // write type
  ss << m_type << " ";

  // write output
  ss << output << " ";

  ss << m_fan_in.size() << " ";
  for (const auto id : m_fan_in) {
    ss << id << " ";
  }
  ss << m_fan_out.size() << " ";
  for (const auto id : m_fan_out) {
    ss << id << " ";
  }

  return ss.str();
}
