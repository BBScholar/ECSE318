#include "simulator.h"

#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <unordered_set>

Simulator::Simulator(const std::string &sym_fn, const std::string &gate_fn) {}

void Simulator::read_symbol_table(const std::string &fn) {
  std::ifstream file(fn, std::ios::binary); // probably shouldnt be binary
  std::string line;

  for (std::string line; std::getline(file, line);) {
    std::cout << line << std::endl;
  }

  file.close();
}

void Simulator::read_gate_list(const std::string &fn) {
  std::ifstream file(fn, std::ios::binary); // TODO: binary?
  std::string line;

  for (std::string line; std::getline(file, line);) {
    std::cout << line << std::endl;
  }

  file.close();
}

void Simulator::run(const std::string &input_fn, const std::string &output_fn) {
  std::ifstream input_file(input_fn, std::ios::binary);
  input_file.close();

  std::ofstream output_file(output_fn, std::ios::binary);
  output_file.close();
}

void Simulator::reset() {
  // for (auto &it = m_gates.begin(); it != m_gates.end(); ++it) {
  // }
}

void Simulator::find_topological_order() {
  m_top_order.clear();
  m_top_order.reserve(m_num_gates);

  // queue of nodes to explore
  std::queue<Gate::GateId> queue;

  // vector containing in degree of each gate
  std::vector<uint32_t> in_degs;
  in_degs.reserve(m_num_gates);

  // gates with no inputs (input degree = 0) put into queue
  for (Gate::GateId i = 0; i < m_num_gates; ++i) {
    const auto &gate = m_gates.at(i);
    const uint32_t ind = gate.get_fan_in().size();
    in_degs.push_back(ind);

    if (ind == 0) {
      queue.push(i);
    }
  }

  while (!queue.empty()) {
    const Gate::GateId current_id = queue.front();
    queue.pop();

    m_top_order.push_back(current_id);

    const Gate &current_gate = m_gates.at(current_id);
    for (const Gate::GateId child_id : current_gate.get_fan_out()) {

      if (--in_degs[child_id] == 0 &&
          current_gate.get_type() != Gate::GateType::DFF) {
        queue.push(child_id);
      }
    }
  }
}
