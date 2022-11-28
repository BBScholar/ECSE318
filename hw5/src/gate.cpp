#include "gate.h"

#include <iostream>
#include <sstream>

std::string Gate::to_string() {
  std::stringstream ss;

  ss << std::to_string((uint8_t)m_type) << "\t";

  uint8_t is_output = (uint8_t)(m_type == GateType::Output);
  ss << std::to_string(is_output) << "\t";

  ss << m_level << "\t";

  ss << m_fan_in.size() << "\t";
  for (const auto &id : m_fan_in) {
    ss << id << "\t";
  }

  ss << m_fan_out.size() << "\t";
  for (const auto &id : m_fan_out) {
    ss << id << "\t";
  }

  ss << m_name;

  return ss.str();
}

Gate::Gate(const std::string &name, GateId id, GateType::GateType type,
           uint32_t level)
    : m_name(name), m_id(id), m_type(type), m_level(level), m_fan_in(),
      m_fan_out() {

  // std::cout << "Creating gate with name: " << name << std::endl;
}
