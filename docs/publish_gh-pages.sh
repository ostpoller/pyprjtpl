#!/usr/bin/env bash

DEBUG=true
PROJDIR=$(readlink -f ..)
BUILDDIR=$(readlink -f ../../project_name-docs)
#ORIGIN=originhttps
ORIGIN=origin
REMOTE_PUSH=$(git remote -v | grep "${ORIGIN}\W.*push" | tr '\t' ' ' | tr -s ' ' | cut -d ' ' -f2)
REMOTE_FETCH=$(git remote -v | grep "${ORIGIN}\W.*fetch" | tr '\t' ' ' | tr -s ' ' | cut -d ' ' -f2)


GREY='\033[0;37m'
WHITE='\033[1;37m'
BLUE='\033[1;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37


function indent() {
    sed 's/^/    /'
}


function debug_msg {
    echo -e "${GREY}[DEBUG] $1${NC}"
}


function info_msg {
    echo -e "${BLUE}[INFO] $1${NC}"
}


function error_msg {
    echo -e "${RED}[ERROR] $1${NC}"
}


function commit_sources {
    # committing and pushing sources to remote repo on branch master
    pushd ${PROJDIR} > /dev/null
      $DEBUG && debug_msg "Checking active branch in $(pwd) ..."
      active_git_branch=$(basename $(git symbolic-ref HEAD))
      $DEBUG && debug_msg "Active branch: ${active_git_branch}"
      if [ "${active_git_branch}" != "master" ]; then
        error_msg "You are not on branch master! Exiting now ..."
        exit 1
      fi
      $DEBUG && debug_msg "Adding to local repo ..."
      git add . 2>&1 | indent
      info_msg "Committing to local repo ..."
      git commit -m 'changes committed by helper script publish.sh' 2>&1 | indent
      info_msg "Pushing to remote repo: ${REMOTE_PUSH} ..."
      git push ${ORIGIN} ${active_git_branch} 2>&1 | indent
      if [ ${PIPESTATUS[0]} -ne "0" ]; then
        error_msg "Push failed! Pull manually first and sort out the conflicts! Then run this script again! --> \'$ git pull origin ${active_git_branch}\'"
        exit 1
      fi
    popd > /dev/null
}


function create_builddir {
    # creating build directory if it does not exist
    info_msg "Creating build directory: ${BUILDDIR}"
    mkdir -p ${BUILDDIR}
}


function clone_gh-pages {
    # cloning remote repo branch gh-pages if it does not exist
    pushd ${BUILDDIR} > /dev/null
      $DEBUG && debug_msg "Deleting contents from build directory (if any) $(pwd) ..."
      rm -rf *
      info_msg "Cloning: git clone -b gh-pages ${REMOTE_FETCH} html ..."
      git clone -b gh-pages ${REMOTE_FETCH} html 2>&1 | indent
    popd > /dev/null
}

function pull_gh-pages {
    pushd ${BUILDDIR}/html > /dev/null
      $DEBUG && debug_msg "Checking active branch in $(pwd) ..."
      active_git_branch=$(basename $(git symbolic-ref HEAD))
      $DEBUG && debug_msg "Active Branch: ${active_git_branch}"
      if [ "${active_git_branch}" != "gh-pages" ]; then
        error_msg "You are not on branch gh-pages! Exiting now ..."
        exit 1
      fi
      info_msg "Pulling from remote repo to retrieve latest changes  ..."
      git pull ${ORIGIN} gh-pages 2>&1 | indent
    popd > /dev/null

}


function build_html_document {
    # build document
    info_msg "Building the document ..."
    make html 2>&1 | indent
}


function publish_html_document {
    # committing and pushing build to remote repo on branch gh-pages (published directly)
    pushd ${BUILDDIR}/html > /dev/null
      $DEBUG && debug_msg "Checking active branch in $(pwd) ..."
      active_git_branch=$(basename $(git symbolic-ref HEAD))
      $DEBUG && debug_msg "Active Branch: ${active_git_branch}"
      if [ "${active_git_branch}" != "gh-pages" ]; then
        error_msg "You are not on branch gh-pages! Exiting now ..."
        exit 1
      fi
      $DEBUG && debug_msg "Adding to local repo ..."
      git add . 2>&1 | indent
      info_msg "Committing to local repo ..."
      git commit -m 'rebuilt docs; changes committed by helper script publish.sh' 2>&1 | indent
      info_msg "Pushing to remote repo: ${REMOTE_PUSH} ..."
      git push ${ORIGIN} gh-pages 2>&1 | indent
    popd > /dev/null
}


function main() {
    commit_sources  # avoid source commits for doc publishing purposes
    if [ ! -d "${BUILDDIR}" ]; then
        create_builddir
    fi
    if [ ! -d "${BUILDDIR}/html" -o ! -d "${BUILDDIR}/html/.git" ]; then
        clone_gh-pages
    else
        pull_gh-pages
    fi
    build_html_document
    publish_html_document
}

main
