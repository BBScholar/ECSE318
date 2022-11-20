#include "simulator.h"

#include <fstream>
#include <iostream>

#include <boost/algorithm/string.hpp>
#include <boost/algorithm/string/trim_all.hpp>

Simulator::Simulator()
    : m_has_model(false), m_has_inputs(false), m_num_gates(0) {
  std::cout << "Initialized simulator" << std::endl;
}

bool Simulator::run() {
  if (!m_has_model || !m_has_inputs) {
    std::cerr << "Cannot run sim without model and inputs" << std::endl;
    return false;
  }
  const int iterations = m_inputs.size();

  for (int iter = 0; iter < iterations; ++iter) {
  }

  return true;
}

bool Simulator::load_model(const std::string &fn) {
  std::cout << "Loading model from file: " << fn << std::endl;
  m_gates.clear();
  m_input_gates.clear();
  m_output_gates.clear();
  m_dff_gates.clear();
  m_inputs.clear();

  m_has_model = false;
  m_has_inputs = false;

  std::ifstream file(fn);

  if (file.bad()) {
    std::cerr << "Could not open file " << fn << std::endl;
    return false;
  }

  GateId current_id = 0;
  GateId child_id;

  GateType::GateType current_type;
  uint32_t current_level, fan_in_n, fan_out_m;

  std::string line;
  std::vector<std::string> splits;

  for (; std::getline(file, line);) {
    // boost::trim(line);
    // if(line.empty()) {
    //   continue;
    // }
    boost::split(splits, line, boost::is_any_of("\t"));

    current_type = (GateType::GateType)std::stoi(splits[0]);
    current_level = std::stoi(splits[2]);
    fan_in_n = std::stoi(splits[3]);
    fan_out_m = std::stoi(splits[3 + fan_in_n + 1]);

    auto gate_p = std::make_shared<Gate>(splits.back(), current_id,
                                         current_type, current_level);

    gate_p->set_state(SignalState::X);
    gate_p->get_fan_in().reserve(fan_in_n);
    gate_p->get_fan_out().reserve(fan_out_m);

    for (int i = 0; i < fan_in_n; ++i) {
      child_id = std::stoi(splits[3 + 1 + i]);
      gate_p->add_input_gate(child_id);
    }

    for (int i = 0; i < fan_out_m; ++i) {
      child_id = std::stoi(splits[3 + 1 + fan_in_n + i]);
      gate_p->add_output_gate(child_id);
    }

    if (current_type == GateType::Input) {
      m_input_gates.push_back(current_id);
    } else if (current_type == GateType::Output) {
      m_output_gates.push_back(current_id);
    } else if (current_type == GateType::Dff) {
      m_dff_gates.push_back(current_id);
    }

    m_gates.insert({current_id, gate_p});
    current_id++;
  }

  m_num_gates = current_id;
  m_has_model = true;
  return true;
}

bool Simulator::load_inputs(const std::string &fn) {
  std::cout << "Loading inputs from file: " << fn << std::endl;
  if (!m_has_model) {
    std::cerr << "Cannot load inputs before valid model has been processed."
              << std::endl;
    return false;
  }
  m_has_inputs = false;
  const uint32_t required_inputs = m_input_gates.size();

  std::ifstream file(fn);

  if (file.bad()) {
    std::cerr << "Could not open file " << fn << std::endl;
    return false;
  }

  m_inputs.clear();
  // SimInput inputs;
  // inputs.reserve(16);

  std::vector<SignalState> row;

  uint32_t line_num = 0;

  for (std::string line; std::getline(file, line); ++line_num) {
    boost::trim(line);

    if (line.empty() || line.starts_with("//")) {
      continue;
    } else if (line.size() < required_inputs) {
      std::cerr << "Line " << line_num
                << "does not have enough inputs for current model" << std::endl;
      return false;
    }
    row.clear();

    for (char &c : line) {
      row.push_back(signal_state_from_char(c));
    }
    m_inputs.push_back(row);
  }
  file.close();

  m_has_inputs = true;

  return true;
}

void Simulator::reset_state() {
  for (GateId i = 0; i < m_num_gates; ++i) {
    m_gates[i]->set_state(SignalState::X);
  }
}

void Simulator::clear() {
  m_inputs.clear();
  m_gates.clear();
  m_input_gates.clear();
  m_output_gates.clear();
  m_dff_gates.clear();
  m_has_model = false;
  m_has_inputs = false;
  m_num_gates = 0;
}

void Simulator::print_inputs(bool with_legend) {
  for (auto &v : m_inputs) {
    for (auto &s : v) {
      std::cout << signal_state_to_char(s);
    }
    std::cout << "\n";
  }
}

void Simulator::print_state(bool with_legend) {
  SignalState state;

  std::cout << "INPUT   : ";
  for (auto &id : m_input_gates) {
    state = m_gates[id]->get_state();
    std::cout << signal_state_to_char(state);
  }

  if (with_legend) {
    std::cout << "\t// ";
    for (auto &id : m_input_gates) {
      std::cout << m_gates[id]->get_name() << ", ";
    }
  }

  std::cout << "\nSTATE   :";

  for (auto &id : m_dff_gates) {
    state = m_gates[id]->get_state();
    std::cout << signal_state_to_char(state);
  }

  if (with_legend) {
    std::cout << "\t// ";
    for (auto &id : m_output_gates) {
      std::cout << m_gates[id]->get_name() << ", ";
    }
  }

  std::cout << "\nOUTPUT  :";

  for (auto &id : m_output_gates) {
    state = m_gates[id]->get_state();
    std::cout << signal_state_to_char(state);
  }

  if (with_legend) {
    std::cout << "\t// ";
    for (auto &id : m_output_gates) {
      std::cout << m_gates[id]->get_name() << ", ";
    }
  }

  std::cout << "\n";
}
