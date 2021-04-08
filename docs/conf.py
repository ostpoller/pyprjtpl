# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# http://www.sphinx-doc.org/en/master/config

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))

import recommonmark
from recommonmark.transform import AutoStructify


# -- Project information -----------------------------------------------------

project = 'package_name'
copyright = '2021, Philipp WESTPHAL'
author = 'Philipp WESTPHAL'


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx_rtd_theme',
    'recommonmark',
    'sphinx_markdown_tables',
]

# Add any paths that contain templates here, relative to this directory.
# templates_path = ['_templates']

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
#
source_suffix = {
    '.rst': 'restructuredtext',
    '.md': 'markdown',
}

# The master toctree document.
master_doc = 'index'

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'emacs'


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_rtd_theme'

html_theme_options = {
    'style_nav_header_background': '#000000',
    'display_version': True,
    'collapse_navigation': True,
    'sticky_navigation': False,
}

html_favicon = './source/res/icon.png'
html_logo = './source/res/logo.png'

html_last_updated_fmt = "%Y-%m-%d %H:%M:%S %Z"

html_show_sphinx = False
html_show_sourcelink = False


# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']
# Custom CSS to set better style for block quote
html_css_files = ['custom.css']


def setup(app):
    app.add_config_value('recommonmark_config', {
            'enable_eval_rst': True,
            }, True)
    app.add_transform(AutoStructify)
