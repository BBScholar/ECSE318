
#include <iostream>
#include <string>
#include <string_view>

#include "simulator.h"

constexpr std::string_view k_default_output_fn = "./output";

int main(int argc, char **argv) {
  if (argc < 3) {
    std::cout << "Not enough arguments supplied!" << std::endl;
    std::cout
        << "Usage: verilog_sim <symbol_file> <gate_list_file> [<output_file>]"
        << std::endl;
    return 1;
  }
  argv++; // get rid of binary path, don't need it

  const std::string sym_fn(argv[0]);
  const std::string gate_fn(argv[1]);

  std::string output_fn(k_default_output_fn);

  if (argc > 3) {
    output_fn = std::string(argv[2]);
  }

  std::cout << "Testing" << std::endl;

  Simulator *sim = new Simulator(sym_fn, gate_fn);

  delete sim;

  return 0;
}
