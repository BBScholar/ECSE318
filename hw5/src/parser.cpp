
#include <fstream>
#include <iostream>
#include <memory>
#include <sstream>
#include <string>
#include <unordered_map>
#include <vector>

#include <boost/algorithm/string.hpp>
#include <boost/algorithm/string/trim_all.hpp>

#include "gate.h"
#include "top.h"

void print_string_vector(const std::vector<std::string> &vec) {
  std::cout << "[";
  for (const std::string &s : vec) {
    std::cout << s << ", ";
  }
  std::cout << "]" << std::endl;
}

int main(int argc, char **argv) {
  // something
  if (argc < 3) {
    std::cout << "Not enough arguments." << std::endl;
    std::cout << "Usage: parser <in_file> <out_file>" << std::endl;
    return 1;
  }
  // increment argv pointer to skip working directory value
  argv++;

  const std::string input_fn(argv[0]);
  const std::string output_fn(argv[1]);

  std::ifstream input_file(input_fn);

  if (input_file.bad()) {
    std::cerr << "Could not open input file: " << input_fn << std::endl;
    return -1;
  }

  // program data
  uint32_t line_num = 0;

  bool in_module = false;
  GateId current_id = 0;
  std::optional<GateType::GateType> current_type_opt;
  GateType::GateType current_type;
  std::string current_name;

  std::vector<std::string> splits;
  splits.clear();
  splits.reserve(64);

  std::unordered_map<GateId, std::shared_ptr<Gate>> gates;
  // std::unordered_map<std::string, GateId> net_inputs;
  std::unordered_map<std::string, std::vector<GateId>> net_outputs;
  std::unordered_map<GateId, std::string> net_inputs;
  // reserve memory to prevent rehashing

  gates.reserve(1024); // TODO: do this in a smarter way?
  net_inputs.reserve(1024);
  net_outputs.reserve(1024);

  // for (std::string line; std::getline(input_file, line, ';');) {
  //   boost::trim_all(line);
  //   boost::to_lower(line);
  // }

  for (std::string line; std::getline(input_file, line, ';'); line_num++) {
    // boost::trim_if(line, boost::is_any_of(" \t"));
    boost::trim_all(line);
    boost::to_lower(line);

    // if empty line or comment continue
    if (line.empty() || line.starts_with("//")) {
      continue;
    }

    if (!in_module && line.starts_with("module")) {
      in_module = true;
      continue;
    } else if (in_module && line.starts_with("endmodule")) {
      in_module = false;
      continue;
    }

    if (!in_module) {
      continue;
    }

    splits.clear();
    boost::split(splits, line, boost::is_any_of(" "));

    if (splits.size() < 2) {
      std::cerr << "Malformed line (" << line_num << "): " << line << std::endl;
      continue;
    }

    if (splits[0] == "wire") {
      std::cout << "Found wires: ";
      boost::split(splits, splits[1], boost::is_any_of(",;"));
      for (const auto &s : splits) {
        if (!s.empty()) {
          std::cout << s << ", ";

          if (!net_outputs.contains(s)) {
            net_outputs[s] = {};
            net_outputs[s].reserve(64);
          }
        }
      }
      std::cout << std::endl;
      continue;
    }

    current_type_opt = gate_type_from_string(splits[0]);
    current_name = splits[1];
    boost::erase_all(current_name, ";"); // remove semicolon from name

    if (!current_type_opt) {
      std::cerr << "Invalid gate type (" << splits[0] << ") at line" << line_num
                << std::endl;
      continue;
    }

    current_type = *current_type_opt;

    auto gate_p =
        std::make_shared<Gate>(current_name, current_id, current_type, 0);

    if (current_type == GateType::Input) {
      net_inputs.insert({current_id, current_name});
    } else if (current_type == GateType::Output) {

      if (!net_outputs.contains(current_name)) {
        // insert output node into output of net
        net_outputs[current_name] = {};
        net_outputs[current_name].reserve(64);
      }
      net_outputs[current_name].push_back(current_id);
    } else {

      if (splits.size() < 3) {
        std::cerr << "Not enough arguments for gate type " << splits[0]
                  << "(line " << line_num << ")" << std::endl;
        continue;
      }

      // TODO: move these variables out of the loop
      std::string::size_type lp, rp, pn;

      lp = splits[2].find_first_of('(');
      rp = splits[2].find_first_of(')');
      pn = (rp) - (lp + 1);

      std::string gate_args;
      gate_args = splits[2].substr(lp + 1, pn);

      // std::cout << "Gate args: " << gate_args << std::endl;

      boost::split(splits, gate_args, boost::is_any_of(","));

      // TOOD: check lengths here
      if (splits.size() < gate_num_inputs(current_type) + 1) {
        std::cerr << "Not enough arguments (" << splits.size() << ")"
                  << std::endl; // TODO: make this print out nicer
        continue;
      }

      // first net listed is the output of the gate
      // add this as the input to the respective net
      net_inputs.insert({current_id, splits[0]});

      // mark this gate as a reader of all the following nets
      for (int i = 1; i < splits.size(); ++i) {
        net_outputs[splits[i]].push_back(current_id);
      }
    }

    gates.insert({current_id++, gate_p});
    // current_id++;
  }
  const GateId max_gate_id = current_id;
  input_file.close();

  // resolve net dependencies
  for (GateId i = 0; i < max_gate_id; ++i) {

    // output gates
    if (!net_inputs.contains(i)) {
      continue;
    }

    const std::string &net_name = net_inputs[i];
    for (auto j : net_outputs[net_name]) {
      gates[i]->add_output_gate(j);
      gates[j]->add_input_gate(i);
    }
  }

  // TODO: resolve top ordering??

  std::vector<GateId> order;
  topological_ordering(max_gate_id, gates);

  // write gates to output file
  std::ofstream output_file(output_fn, std::fstream::out);

  if (output_file.bad()) {
    std::cerr << "Could not open output file (" << output_fn << ")"
              << std::endl;
    return -1;
  }

  for (GateId i = 0; i < max_gate_id; ++i) {
    output_file << gates[i]->to_string() << "\n";
  }

  output_file.close();

  return 0;
}
