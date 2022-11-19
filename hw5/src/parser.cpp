#include <fstream>
#include <iostream>
#include <string>

#include "gate.h"

int main(int argc, char **argv) {
  if (argc < 3) {
    std::cout << "Not enough argumets" << std::endl;
    std::cout << "Usage: verilog_parser <in_file> <out_file>" << std::endl;
    return 1;
  }
  argv++;

  const std::string in_fn(argv[0]);
  const std::string out_fn(argv[1]);

  std::ifstream in_file(in_fn);

  for (std::string line; std::getline(in_file, line);) {
  }

  in_file.close();

  return 0;
}
