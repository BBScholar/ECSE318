#pragma once

#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include "types.h"

class Gate {
public:
  typedef uint32_t GateId;

  enum GateType { Input, Output, DFF };

public:
  Gate(GateId id, GateType type, const std::string &name, SignalState state);

  Gate(Gate &&) = delete;
  Gate(const Gate &) = delete;

  ~Gate() = default;

  void update_state();

  // to string method
  std::string to_string() const;

  // getters and setters
  void set_state(SignalState state);
  SignalState get_state() const;

  GateType get_type() const;

  const std::string &get_name() const;

  const std::vector<GateId> &get_fan_in() const;
  const std::vector<GateId> &get_fan_out() const;

public:
  std::optional<Gate> from_string(const std::string &s);

private:
  GateId m_id;
  GateType m_type;

  std::string m_name;

  SignalState m_state;

  std::vector<GateId> m_fan_in;
  std::vector<GateId> m_fan_out;
};
