#pragma once

#include <memory>
#include <string>
#include <unordered_map>
#include <vector>

#include "gate.h"

using GateMap = std::unordered_map<GateId, std::shared_ptr<Gate>>;

std::vector<GateId> topological_ordering(uint32_t num_gates, GateMap &gate_map);
