"""
Add the project's top level directory to the search path.

This enables any python script to import the package without installation:

    from context import package_name

Note: 
Relative imports don't work when the module is executed directly (as __main__).
Therefore the import of context in any script must be absolute and relies on the 
fact that Python searches for importable modules in the same directory as the
input script is located in.

"""

import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))


import package_name  # noqa
