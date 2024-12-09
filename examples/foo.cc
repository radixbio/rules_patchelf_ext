#include "foo.h"
#include <iostream>

void exported_function() {
  std::cout << "called from shared library" << std::endl;
}
