#include "simulator.h"

#include <chrono>
#include <fstream>
#include <iostream>

#include <boost/algorithm/string.hpp>
#include <boost/algorithm/string/trim_all.hpp>

#include "lut.h"

Simulator::Simulator()
    : m_has_model(false), m_has_inputs(false), m_num_gates(0) {
  std::cout << "Initialized simulator" << std::endl;
}

bool Simulator::run(const std::string &fn) {
  if (!m_has_model || !m_has_inputs) {
    std::cerr << "Cannot run sim without model and inputs" << std::endl;
    return false;
  }
  reset_state();

  std::ofstream out_file(fn);

  if (out_file.bad()) {
    std::cerr << "Could not open output file " << fn << std::endl;
    return false;
  }

  using std::chrono::duration_cast;
  using std::chrono::microseconds;
  using clock = std::chrono::high_resolution_clock;

  auto start = clock::now();

  const int iterations = m_inputs.size();

  for (int i = 0; i < iterations; ++i) {
    // read inputs and schedule fanouts of changed inputs.
    update_inputs(i);
    // load next state and schedule fanout.
    update_state();

    // traverse tree
    for (int j = 0; j < m_top_order.size(); ++j) {
      GateId current_id = m_top_order[j];
      if (m_needs_update[current_id]) {
        if (evaluate_gate(current_id)) { // TODO: schedule fanout
          schedule_fanout(current_id);
        }
        m_needs_update[current_id] = false;
      }
    }
    // print logic values at PI, PO, and States
    print_state(out_file, i == 0);
  }

  auto end = clock::now();

  std::cout << "Simulation took "
            << duration_cast<microseconds>(end - start).count() << "us to run."
            << std::endl;

  return true;
}

void Simulator::schedule_fanout(GateId id) {
  for (GateId &child_id : m_gates[id]->get_fan_out()) {
    // std::cout << "Gate " << m_gates[id]->get_name() << " (" << id << ") is
    // scheduling " << m_gates[child_id]->get_name()  << " (" << child_id << ")
    // for update" << std::endl;
    m_needs_update[child_id] = true;
  }
}

void Simulator::update_state() {
  SignalState prev_state, next_state;
  GateId id;

  for (int i = 0; i < m_dff_gates.size(); ++i) {
    id = m_dff_gates[i];
    prev_state = m_gates[id]->get_state();
    next_state = m_gates[m_gates[id]->get_fan_in()[0]]->get_state();

    if (prev_state != next_state) {
      m_gates[id]->set_state(next_state);
      schedule_fanout(id);
    }

    m_needs_update[id] = false;
  }
}

void Simulator::update_inputs(uint32_t iteration) {
  SignalState prev_state, next_state;
  GateType::GateType type;
  GateId id;

  for (int i = 0; i < m_input_gates.size(); ++i) {
    id = m_input_gates[i];
    prev_state = m_gates[id]->get_state();
    next_state = m_inputs[iteration][i];

    if (prev_state != next_state) {
      m_gates[id]->set_state(next_state);
      schedule_fanout(m_input_gates[id]);
    }

    m_needs_update[id] = false;
  }
}

bool Simulator::evaluate_gate(GateId id) {

  GateType::GateType type = m_gates[id]->get_type();

  SignalState prev_state, next_state;

  prev_state = m_gates[id]->get_state();

  if (type == GateType::Dff || type == GateType::Input) {
    return false;
  } else if (type == GateType::Output) {
    // TODO: something here
    next_state = m_gates[m_gates[id]->get_fan_in()[0]]->get_state();
    m_gates[id]->set_state(next_state);
    return false;
  }

#define INPUT_SCAN
#ifdef INPUT_SCAN
  next_state = input_scan(id);
#else
  next_state = table_lookup(id);
#endif

  m_gates[id]->set_state(next_state);
  // std::cout << "Setting " << m_gates[id]->get_name() << " (" << id << ")
  // changing to state " << signal_state_to_char(next_state) << std::endl;

  return next_state != prev_state;
  // else do stuff
}

SignalState Simulator::input_scan(GateId id) {
  bool uvalue = false;
  const auto type = m_gates[id]->get_type();
  const uint8_t c = lut::k_c_input[lut::gate_type_to_lut_index(type)];
  const uint8_t i = lut::k_i_input[lut::gate_type_to_lut_index(type)];
  const SignalState cxi = lut::signal_state_from_int(c ^ i);

  for (GateId child_id : m_gates[id]->get_fan_in()) {
    const uint8_t V =
        lut::signal_state_to_lut_index(m_gates[child_id]->get_state());
    if (V == c)
      return cxi;
    else if (V == 2)
      uvalue = true;
  }

  if (uvalue)
    return SignalState::X;

  return lut::signal_state_from_int(c ^ !i);
}

SignalState Simulator::table_lookup(GateId id) {
  // const auto initial_state =
  const auto &gate = m_gates[id];
  const auto type = gate->get_type();
  const auto type_idx = lut::gate_type_to_lut_index(type);

  SignalState first_state = m_gates[gate->get_fan_in()[0]]->get_state();

  if (type == GateType::Not)
    return lut::signal_state_from_int(
        lut::k_inv_table[lut::signal_state_to_lut_index(first_state)]);
  // else if (type == GateType::Buf)
  //   return lut::k_buf_table[lut::signal_state_to_lut_index(first_gate)];

  for (int i = 1; i < m_gates[id]->get_fan_in().size(); ++i) {
    SignalState s2 = m_gates[m_gates[id]->get_fan_in()[i]]->get_state();
    const uint8_t l1 = lut::signal_state_to_lut_index(first_state);
    const uint8_t l2 = lut::signal_state_to_lut_index(s2);
    first_state = lut::signal_state_from_int(lut::k_table[type_idx][l1][l2]);
  }

  if (lut::k_i_input[type_idx])
    return lut::signal_state_from_int(
        lut::k_inv_table[lut::signal_state_to_lut_index(first_state)]);

  return first_state;
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

  int num_lines = 0;

  for (; std::getline(file, line);)
    num_lines++;
  file.clear();
  file.seekg(0, std::ios::beg);

  m_gates.reserve(num_lines);
  m_input_gates.reserve(num_lines);
  m_output_gates.reserve(num_lines);
  m_dff_gates.reserve(num_lines);

  // m_top_order.reserve(num_lines);
  // m_needs_update.reserve(num_lines);
  m_top_order.clear();
  m_top_order.resize(num_lines, 0);

  m_needs_update.clear();
  m_needs_update.resize(num_lines, false);

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
      child_id = std::stoi(splits[3 + 2 + fan_in_n + i]);
      gate_p->add_output_gate(child_id);
    }

    if (current_type == GateType::Input) {
      m_input_gates.push_back(current_id);
    } else if (current_type == GateType::Output) {
      m_output_gates.push_back(current_id);
    } else if (current_type == GateType::Dff) {
      m_dff_gates.push_back(current_id);
    }

    m_top_order[current_level] = current_id;
    m_needs_update[current_id] = false;
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
  m_inputs.reserve(16);

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

void Simulator::print_state(std::ofstream &of, bool with_legend) {
  SignalState state;

  of << "INPUT   :";
  for (auto &id : m_input_gates) {
    state = m_gates[id]->get_state();
    of << signal_state_to_char(state);
  }

  if (with_legend) {
    of << "\t// ";
    for (auto &id : m_input_gates) {
      of << m_gates[id]->get_name() << ", ";
    }
  }

  of << "\nSTATE   :";

  for (auto &id : m_dff_gates) {
    state = m_gates[id]->get_state();
    of << signal_state_to_char(state);
  }

  if (with_legend) {
    of << "\t// ";
    for (auto &id : m_dff_gates) {
      of << m_gates[id]->get_name() << ", ";
    }
  }

  of << "\nOUTPUT  :";

  for (auto &id : m_output_gates) {
    state = m_gates[id]->get_state();
    of << signal_state_to_char(state);
  }

  if (with_legend) {
    of << "\t// ";
    for (auto &id : m_output_gates) {
      of << m_gates[id]->get_name() << ", ";
    }
  }

  of << "\n\n";
}
