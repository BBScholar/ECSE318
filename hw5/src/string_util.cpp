#include "string_util.h"

#include <array>
#include <algorithm>
#include <unordered_set>

const std::unordered_set<char> whitespace = {' ', '\n', '\t'};

namespace util {
void split(std::vector<std::string>& splits, const std::string& s, const std::string& delim) {
    // splits.clear();

    std::vector<std::string> new_splits;

    std::unordered_set<char> delim_set;
    for(const char c : delim) {
        delim_set.insert(c);
    }

    std::size_t left = 0, right = 0;

    while(right <= s.size()) {
        while(right != s.size() && delim_set.count(s[right]) == 0) {
            right++;
        }

        if(right != left)
            new_splits.push_back(s.substr(left, right - left));
        right++;
        left = right;
    }

    splits = new_splits;
}


void trim(std::string& s) {

    std::size_t front = 0, back = s.size(); 

    while(front != back && whitespace.count(s.at(front)) > 0)
        front++;
    
    while(back != front && whitespace.count(s.at(back - 1)) > 0)
        back--;

    // return s.substr(front, back);
    s = s.substr(front, back - front);
}

void replace_char(std::string& s, char before, char after) {
    if(before == after) return;
    while(contains(s, std::string(1, before))) {
        auto idx = s.find_first_of(before);
        s[idx] = after;
    }
}

void trim_all(std::string& s) {
    trim(s);

    for(const auto & c : whitespace) {
        replace_char(s, c, ' ');
    }

    while(contains(s, "  ")) {
        auto idx = s.find("  ") + 1; // find all instances of 2 spaces in a row
//        while(s[idx] == ' ') s.erase(idx); // remove duplucate spaces
        s.erase(idx, 1);
    }
}

void erase_all_char(std::string& s, char c) {
    while(contains(s, std::string(1, c))) {
        auto idx = s.find_first_of(c);
        s.erase(idx);
    }
}

bool contains(const std::string& s, const std::string& c) {
    return s.find(c) != std::string::npos;
}

}