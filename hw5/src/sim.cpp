
#include <chrono>
#include <iostream>
#include <string>

#include "simulator.h"

int main(int argc, char **argv) {
  using std::chrono::duration_cast;
  using std::chrono::microseconds;
  using std::chrono::milliseconds;
  using std::chrono::nanoseconds;
  using clock = std::chrono::high_resolution_clock;

  argc--;
  argv++;

  if (argc < 3) {
    std::cerr
        << "Not enough arguments. Usage: verilog_sim <gate file> <input file>"
        << std::endl;
    return 1;
  }

  const std::string gate_fn(argv[0]);
  const std::string input_fn(argv[1]);
  const std::string output_fn(argv[2]);

  auto start = clock::now();

  auto *sim = new Simulator();

  if (!sim->load_model(gate_fn)) {
    std::cerr << "Could not load gate model" << std::endl;
    return -1;
  }

  if (!sim->load_inputs(input_fn)) {
    std::cerr << "Could not load input file" << std::endl;
    return -1;
  }

  sim->run(output_fn);

  auto end = clock::now();
  std::cout << "Program took "
            << duration_cast<microseconds>(end - start).count() << "us to run."
            << std::endl;

  return 0;
}
