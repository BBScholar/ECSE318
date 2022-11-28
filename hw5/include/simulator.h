#pragma once

#include <fstream>
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

  bool run(const std::string &fn);

  void reset_state();
  void clear();

private:
  void print_inputs(bool with_legend = false);
  void print_state(std::ofstream &of, bool with_legend = false);

  // returns true if state changed
  bool evaluate_gate(GateId id);
  // SignalState calculate_next(const std::vector<SignalState>& state, )

  SignalState input_scan(GateId id);
  SignalState table_lookup(GateId id);

  void update_inputs(uint32_t iteration);
  void update_state();
  void schedule_fanout(GateId id);

private:
  bool m_has_model, m_has_inputs;

  uint32_t m_num_gates;

  std::unordered_map<GateId, std::shared_ptr<Gate>> m_gates;

  std::vector<GateId> m_input_gates;
  std::vector<GateId> m_output_gates;
  std::vector<GateId> m_dff_gates;

  std::vector<GateId> m_top_order;
  std::vector<bool> m_needs_update;

  SimInput m_inputs;
};
