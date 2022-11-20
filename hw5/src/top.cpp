#include "top.h"

#include <cstdint>
#include <queue>

// TODO: make sure DFFs are inserted before inputs
std::vector<GateId> topological_ordering(uint32_t num_gates,
                                         GateMap &gate_map) {

  std::unordered_map<GateId, uint32_t> in_deg_map;
  std::queue<GateId> queue;
  std::vector<GateId> order;

  in_deg_map.reserve(num_gates);
  // queue.reserve(num_gates);
  order.reserve(num_gates);

  int in_deg;
  GateType::GateType type;

  for (GateId i = 0; i < num_gates; ++i) {
    type = gate_map[i]->get_type();
    if (type == GateType::Dff) {
      queue.push(i);
    }
  }

  for (GateId i = 0; i < num_gates; ++i) {
    in_deg = gate_map[i]->get_fan_in().size();
    type = gate_map[i]->get_type();
    if (type == GateType::Dff) {
      continue;
    } else if (in_deg == 0) {
      queue.push(i);
      continue;
    }
    in_deg_map.insert({i, in_deg});
  }

  GateId current_id;
  uint32_t order_num = 0;
  while (!queue.empty()) {
    // remove top element from queue
    current_id = queue.front();
    queue.pop();

    // push id into the order
    order.push_back(current_id);

    // set order_num in gate
    gate_map[current_id]->set_level(order_num++);

    //
    for (GateId &child_id : gate_map[current_id]->get_fan_out()) {
      if (in_deg_map.contains(child_id)) { // ensure that no DFFs end up here
        in_deg_map[child_id]--;

        if (in_deg_map[child_id] == 0) { // if no more parents, add to queue
          in_deg_map.erase(child_id);
          queue.push(child_id);
        }
      }
    }
  }

  if (!in_deg_map.empty()) {
    std::cerr << "Topological sort not completed" << std::endl;
    for (auto &e : in_deg_map) {
      std::cerr << "Failed to remove gate with Id " << e.first << std::endl;
    }
  }

  return order;
}
