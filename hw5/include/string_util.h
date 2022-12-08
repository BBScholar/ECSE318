#pragma once

#include <vector>
#include <string>
namespace util {
void split(std::vector<std::string>& splits, const std::string& s, const std::string& delim);
void trim(std::string& s);
void trim_all(std::string& s);
void erase_all(std::string& s, char c);
void erase_all_char(std::string& s, char c);
bool contains(const std::string& s, const std::string &c);
}