
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

  if (argc < 3) {
    std::cerr
        << "Not enough arguments. Usage: verilog_sim <gate file> <input file>"
        << std::endl;
    return 1;
  }
  // get rid of unused argument
  argv++;

  const std::string gate_fn(argv[0]);
  const std::string input_fn(argv[1]);

  auto *sim = new Simulator();

  if (!sim->load_model(gate_fn)) {
    std::cerr << "Could not load gate model" << std::endl;
    return -1;
  }

  if (!sim->load_inputs(input_fn)) {
    std::cerr << "Could not load input file" << std::endl;
    return -1;
  }

  auto start = clock::now();
  sim->run();
  auto end = clock::now();
  std::cout << duration_cast<microseconds>(end - start).count() << "us"
            << std::endl;

  return 0;
}
