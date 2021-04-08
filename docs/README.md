# package_name Documentation

The documents are written in 
[*reStructuredText*](https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html) or
[*CommonMark*](https://commonmark.org/) (a [Markdown](https://daringfireball.net/projects/markdown/syntax) variant.)
and processed with 
[*Sphinx*](http://www.sphinx-doc.org)


## Edit Document Sources

The document sources are located in `docs/source` or subdirectories therein
and have the extension `*.rst` or `*.md`. 
Supporting media, like images, are located in `res/` directories in the source directories.


## Install ``sphinx`` 

Make sure your virtual environment is activated before running ``pip install``.

```bash
(venv)$ pip install sphinx  sphinx_rtd_theme recommonmark sphinx_markdown_tables
```


## Build the Documentation

The build process will create a directory called `project_name-docs/` (if it does not exist already)
on the same filesystem level as the project directory of `project_name/`. 
This is the target directory for the build process and will eventually contain the final (html) document:

```bash
(venv)$ pwd
/path/to/projects/project_name
(venv)$ cd ..
(venv)$ pwd
/path/to/projects/
(venv)$ tree -L 1
.
├── ...
├── project_name
├── project_name-docs  # this directory will be created by the build process if not already present
└── ...
```

Back in the `project_name/` directory, change into the `docs/` directory. Here you will find a `Makefile`.
Execute the `Makefile` with a target built `html`:

```bash
(venv)$ cd /path/to/projects/project_name
(venv)$ cd docs
(venv)$ pwd
/path/to/projects/project_name/docs
(venv)$ ls -1
Makefile  # Makefile contains build recipe
source
...
(venv)$ make html
...  # Sphinx prints output here
```

## (Pre-) View the (Local) Document

Go to `project_name-docs/`, then into `html/` and open the `index.html` file in a browser:

```bash
$ cd /path/to/projects/project_name-docs
$ cd html
$ pwd
/path/to/projects/project_name-docs/html
$ xdg-open index.html
```


## Publish the Documentation

### Publishing with GitHub-Pages

#### Automated Building & Publishing Process using `publish_gh-pages.sh`

Add your changes to the sources and then run the `publish_gh-pages.sh` script.

There is no need to explicitly call `make html`. `publish_gh-pages.sh` will do this for you!

```bash
$ cd /path/to/projects/project_name/docs
$ ./publish_gh-pages.sh
```

If someone else pushed a newer versions of the sources to the remote repo after your `clone` or last `pull`,
the script fails to automatically push your source changes to the remote repo. It does that on purpose!!! 
Do a manual `git pull origin master` and sort out the conflicts in the source files.

You may experience the same issue with the generated files in the build directory `project_name-docs/html`.
Don't bother to resolve the conflicts by hand. In that case follow the instructions in the next section 
"Manual Publishing Process in the Command Line" to delete and rebuild the `project_name-docs/html` build directory.


#### Manual Publishing Process in the Command Line

In case you have built the document to `project_name-docs/html/` as described above,
remove the contents of `project_name-docs/` completely (not the `project_name-docs` directory itself):

```bash
$ cd /path/to/projects/project_name-docs
$ rm -rf *
```

The project's Git repository must be configured to serve the documentation from a branch called `gh-pages`.

Anything committed and pushed to this branch will be published!

You clone the repository and specifically the branch `gh-pages` into `project_name-docs/` with the name `html`. 
This basically re-creates the `html/` directory that the Sphinx build process expects. 
However, this time the `html/` directory is actually a clone of the repository with the branch `gh-pages` checked out:

```bash
$ cd /path/to/projects/project_name-docs
$ git clone -b gh-pages https://github.com/xxx/project_name.git html
...
$ tree -a -L 2
.
└── html
    ├── contacts.html
    ├── ...
    ├── .buildinfo
    ├── genindex.html
    ├── .git
    ├── _images
    ├── index.html
    ├── .nojekyll
    ├── objects.inv
    ├── search.html
    ├── searchindex.js
    ├── _sources
    └── _static
$ cd html
$ git branch
* gh-pages
$
```

Don't modify the files herein manually. Only ever use Sphinx to build these files!

Don't create other branches. Always leave this local repo checked out on branch `gh-pages`! 

You now build the final document from sources in the `master` branch of your local repo `/path/to/projects/project_name` 
to the `gh-pages` branch in your local repo `/path/to/projects/project_name-docs/html`!
You either do that with `make` by issueing the command `$ make html` or run the script `publish_gh-pages.sh`.

Preview your freshly built document in `/path/to/projects/project_name-docs/html` in a browser and if satisfactory 
commit and push your changes on the `gh-pages` branch.

```bash
$ cd /path/to/projects/project_name-docs/html
$ firefox index.html  # all good here
$ git add .
...
$ git commit -m 'rebuilt docs'
...
$ git push origin gh-pages 
```

Finally, don't forget to commit and push the source documents on the `master` branch in `/path/to/projects/project_name`:

```bash
$ cd /path/to/projects/project_name
$ git branch
* master  # active branch is marked by an asterisk
  <other_branch>
$ git add .
...
$ git commit -m 'describe changes here'
...
$ git push origin master
...
```

The entire workflow is scripted in ``docs/publish_gh-pages.sh``. 
Just running this script from within the ``docs/`` directory
will build, commit and publish the document. 
But be careful, it will not check if the build was successful. It is your 
responsibility to check that the published document is of acceptable quality!


#### How-To Serve Github-Pages from Branch `gh-pages` (FOR REFERENCE ONLY - DO NOT USE!)

This section describes the process when you start from scratch (for future reference) and is otherwise absolutely NOT 
applicable.

```bash
$ mkdir /path/to/projects/my_project
$ cd /path/to/projects/my_project
$ git init
$ touch README.md
$ mkdir -p docs/source
$ cd docs
$ touch source/index.rst
$ touch source/my_document.rst
$ sphinx-quickstart
$ ...  # modify conf.py, Makefile, ... to your needs
$ cd /path/to/projects/my_project
$ git add .
$ git commit -m 'basic Sphinx project layout created'
$ git remote add origin https://github.com/xxx/my_project.git
$ git push origin master
$
$
$ mkdir -p /path/to/projects/my_project-docs
$ cd /path/to/projects/my_project-docs
$ git clone ghttps://github.com/xxx/my_project.git html
$ cd html
$ git branch gh-pages
$ git symbolic-ref HEAD refs/heads/gh-pages
$ rm .git/index
$ git clean -fdx
$ git branch  # confirm you are on gh-pages
* gh-pages
$
$
$ cd /path/to/projects/my_project/docs
$ nedit Makefile  # change BUILDDIR to ../../my_project-docs
$ cd /path/to/projects/my_project
$ git add .
$ git commit -m 'Makefile changed to build to external directory ../my_project-docs'
```

Build, commit and push `my_project` and `my_project-docs` as per previous sections.


## Markup Syntax

### reStructuredText

reStructured text, processed by Sphinx, is the de-facto standard for creating documentation in Python projects.
The markup syntax of reStructuredtext offers everything a document writer could ever want.  

* [A ReStructuredText Primer](http://docutils.sourceforge.net/docs/user/rst/quickstart.html)
* [Quick reStructuredText](http://docutils.sourceforge.net/docs/user/rst/quickref.html)


### Markdown

Markdown has many different flavors and varying syntax specifications, because the original Markdown syntax 
by John Gruber and reference implementation in Perl was neither fully specified, nor was it unambiguous.

However, the unobtrusive markup of Markdown is a joy to work with and markdown is very popular. 
Besides Sphinx, a very nice renderer is Pandoc.
 
* [CommonMark](https://commonmark.org/)
* [Original Markdown by John Gruber](https://daringfireball.net/projects/markdown/syntax)
* [Pandoc's Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown)


## Contacts

Philipp WESTPHAL – [philipp.westphal@gmx.net](mailto:philipp.westphal@gmx.net)


