import os

from setuptools import setup, find_packages


here = os.path.abspath(os.path.dirname(__file__))

try:
    about = {}
    with open(os.path.join(here, 'package_name', '__version__.py'), 'r',
              encoding='utf-8') as f:
        exec(f.read(), about)
except FileNotFoundError:
    raise RuntimeError('No package and version info found.')

try:
    with open(os.path.join(here, 'README.md'), 'r',
              encoding='utf-8') as f:
        long_description = '\n' + f.read()
except FileNotFoundError:
    long_description = about['__description__']

try:
    with open(os.path.join(here, 'requirements_locked.txt')) as f:
        install_requires = f.readlines()
except FileNotFoundError:
    raise RuntimeError('No requirements info found.')


setup(
    name=about['__name__'],
    description=about['__description__'],
    long_description=long_description,
    long_description_content_type='text/markdown',
    version=about['__version__'],
    author=about['__author__'],
    license=about['__license__'],
    url=about['__url__'],
    packages=find_packages(exclude=['tests', 'tests.*'], where='.'),
    # package_dir={'': '.'},
    # py_modules=['mypackage'], # if not a package but individual modules
    # entry_points={
    #     'console_scripts': [
    #         'package_name=app:main',
    #     ],
    # },
    # scripts=[
    #     'scripts/script.py',
    # ],
    # package_data={
    #     'package_name': ['package_data.dat'],
    # },
    # data_files=[('my_data', ['data/data_file'])],
    install_requires=install_requires,
    python_requires='>=3.8',
    include_package_data=True,
    zip_safe=False,
    classifiers=about['__classifiers__'],
    keywords=about['__keywords__'],
)
