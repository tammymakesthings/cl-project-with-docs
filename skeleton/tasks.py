"""
Task definitions for pyinvoke to build documentation
"""

import os
import sys
from pathlib import Path

from invoke import run
from invoke.tasks import task

ROOT_PATH = Path(__FILE__).parent

@task
def build(ctx):
    """Builds the system"""
    return run('sbcl --no-userinit --load ./scripts/build-system.lisp --quit')

def test(ctx):
    """Tests the system"""
    return run('sbcl --no-userinit --load ./scripts/test-system.lisp --quit')

@task
def build_docs(ctx):        # pylint:disable=unused-argument
    """Builds html documentation and updates gh-pages branch.
    """
    def git(cmd):
        return run(f'cd docs/build/html && git {cmd}')

    # build docs
    run('cd docs && make html')

    # If project's directory is git repository
    if os.path.exists('.git'):
        # if no git repository in docs/build/html,
        # then init one
        if not os.path.exists('docs/build/html/.git'):
            result = run("git remote -v | grep '^origin.*(push)$'", warn=True)

            if result:
                if result.failed:
                    print('There is no "origin" remote in this git repository.')
                    print('Please, add remote and push it to the Github.')
                    sys.exit(1)
                else:
                    origin = result.stdout.strip().split()[1]
                    git('init')
                    git(f'remote add origin {origin}')

        git('add .')
        git('commit -m "Update docs"')
        git('push --force origin master:gh-pages')
    else:
        # If project's directory is not a repository
        # then we don't know where to push the docs.
        print('This project is not a git repository.')
        print('Please, push it to the GitHub and run this command')
        print('again. Then we\'ll be able to update gh-pages branch.')
        sys.exit(1)
