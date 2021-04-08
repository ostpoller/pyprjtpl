"""
Make public API available on top level of package.

Clients can now use the API regardless of the internal
project structure simply by calling:

    from package_name import api_function

"""

from .api import *  # noqa: F401 F403
