#include "foo.h"
#include <iostream>

void exported_function() {
  std::cout << "replaced by patchelf" << std::endl;
}
