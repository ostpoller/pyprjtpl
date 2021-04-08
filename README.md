# Python Project Template & Setup - pyprjtpl

This is a Python project skeleton layout and setup.

It includes typical files, metadata and configurations for initiating, developing, 
testing, linting and packaging a Python project.


## Installation 

Clone the repo to where you want to create you new project:

```shell
$ cd /path/to/projects
$ git clone https://github.com/ostpoller/pyprjtpl.git project_name
```

## Usage

To use the template for your project run the script ``configure_project.sh``.
This will replace the placeholders in all files with your project and package name
as well as the package directory name.

A Python virtual environment is created also. After creation activate it and install 
the dependencies for the project setup:

```shell
(venv)$ cd /path/to/projects/project_name
(venv)$ pip install -r requirements_dev.txt
```

Develop your package, add your project dependensies to ``requirements.txt`` and use `make`
to execute typical chores like running the test case suite, lint your code, create documentation, 
bump the version or lock your dependencies.
 
```shell
(venv)$ cd /path/to/projects/project_name
(venv)$ make test
```

## Development

n/a


## Release History

* 0.1.0
    * The initial release


## Issues & ToDos

[https://github.com/ostpoller/pyprjtpl/issues](https://github.com/ostpoller/pyprjtpl/issues)


## Contact

Philipp WESTPHAL –  philipp.westphal@gmx.net

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/ostpoller/pyprjtpl](https://github.com/ostpoller/pyprjtpl)


## References

* [https://packaging.python.org](https://packaging.python.org)
* [https://github.com/pypa/sampleproject](https://github.com/pypa/sampleproject)
* [https://docs.python-guide.org](https://docs.python-guide.org)

* [https://towardsdatascience.com/ultimate-setup-for-your-next-python-project-179bda8a7c2c](https://towardsdatascience.com/ultimate-setup-for-your-next-python-project-179bda8a7c2c)
* [https://github.com/MartinHeinz/python-project-blueprint](https://github.com/MartinHeinz/python-project-blueprint)

* [https://realpython.com/python-code-quality/](https://realpython.com/python-code-quality/)
* [https://realpython.com/lessons/production-vs-development-dependencies/](https://realpython.com/lessons/production-vs-development-dependencies/)

* [https://meta.pycqa.org/en/latest/#](https://meta.pycqa.org/en/latest/#)
* [https://news.ycombinator.com/item?id=22853538](https://news.ycombinator.com/item?id=22853538)
* [https://hackernoon.com/10-common-security-gotchas-in-python-and-how-to-avoid-them-e19fbe265e03](https://hackernoon.com/10-common-security-gotchas-in-python-and-how-to-avoid-them-e19fbe265e03)

* [http://mypy-lang.org/](http://mypy-lang.org/)
* [https://flake8.pycqa.org/en/latest/index.html#](https://flake8.pycqa.org/en/latest/index.html#)
* [https://github.com/psf/black](https://github.com/psf/black)
* [https://pycqa.github.io/isort/](https://pycqa.github.io/isort/)
* [https://bandit.readthedocs.io/en/latest/](https://bandit.readthedocs.io/en/latest/)

* [https://pypi.org/project/pyclean/](https://pypi.org/project/pyclean/)

* [https://choosealicense.com](https://choosealicense.com)
