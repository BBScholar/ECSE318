#pragma once

#include <queue>
#include <string>
#include <unordered_map>

#include "gate.h"

class Simulator {
public:
  Simulator(const std::string &sym_fn, const std::string &gate_fn);
  ~Simulator() = default;

  void run(const std::string &input_fn, const std::string &output_fn);
  void reset();

  // void run_all(); // TODO: ability to add multiple input files?

private:
  void read_symbol_table(const std::string &fn);
  void read_gate_list(const std::string &fn);

  void find_topological_order();

private:
  uint32_t m_num_gates;

  // table that maps node number to string
  std::unordered_map<Gate::GateId, std::string> m_symbol_table;
  // table mapping node number to Gate object
  std::unordered_map<Gate::GateId, Gate> m_gates;
  // table mapping
  std::unordered_map<Gate::GateId, bool> m_needs_update;

  // topological ordering of the nodes
  std::vector<Gate::GateId> m_top_order;

  // event queue
  std::queue<Gate::GateId> m_events, m_next_events;
};
