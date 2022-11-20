#pragma once

#include <memory>
#include <string>
#include <unordered_map>
#include <vector>

#include "gate.h"

class Simulator {
public:
  using SimInput = std::vector<std::vector<SignalState>>;

public:
  Simulator();
  ~Simulator() = default;

  bool load_model(const std::string &fn);
  bool load_inputs(const std::string &fn);

  bool run();

  void reset_state();
  void clear();

private:
  void print_inputs(bool with_legend = false);
  void print_state(bool with_legend = false);

private:
  bool m_has_model, m_has_inputs;

  uint32_t m_num_gates;

  std::unordered_map<GateId, std::shared_ptr<Gate>> m_gates;

  std::vector<GateId> m_input_gates;
  std::vector<GateId> m_output_gates;
  std::vector<GateId> m_dff_gates;

  SimInput m_inputs;
};
