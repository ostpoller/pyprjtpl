"""
Add the project's top level directory to the search path.

This enables pytest modules to import the package without installation:

    from .context import package_name

"""

import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))


import package_name  # noqa