Source Code Management
======================

.. contents:: Table of Contents

See also: Administrative, Configuration Management, LFH, Shell

git
---

git
~~~

Package: git

Git is used for version controlling files.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--work-tree=<PATH> --git-dir=<PATH>/.git", "change the git working directory to ``<PATH>``"
   "init", "initlaize an empty git directory"
   "reset --hard", "deletes all local changes"
   "status -v", "shows files that have been modified and not pushed yet"
   "diff <BRANCH_OR_COMMIT>", "shows deletions and inserts of the actual changes between this branch and a specified branch"
   "fetch --tags", "pull the latest tags"
   "grep", "search for specific strings in all of the files"
   "blame", "show who made a specific commit"
   "merge --squash", "condense all commits into one"
   "reflog <BRANCH>", "show the local git history"
   "-c", "specify a configuration option to temporarily override"
   "-c http.sslVerify=false", "turn off SSL vertification to use self-signed SSLs"

git remote
~~~~~~~~~~

Configure additional related Git repositories to manage.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "add origin", "add a GitHub project URL"
   "set-url origin", "change the repo URL"
   "set-url origin git@github.com:<GITHUB_USER>/<PROJECT>.git", "change a local repository to use a SSH connection to GitHub"

git config
~~~~~~~~~~

Manage the local settings for git repositories and users.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--global", "modify the global configuration"
   "--list", "shows current Git user information"
   "--get <KEY>.<VALUE>", "shows what a specific variable is set to"
   "user.name", "change username"
   "user.email", "change e-mail"
   "remote.origin.url", "the repository URL"
   "--unset <KEY>.<VALUE>", "unset a variable"

git clone
~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "--depth <DEPTH>", "only download the last <DEPTH> amount of commits"

git pull
~~~~~~~~

Download the latest commits from a remote git repository.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "origin", "download all of the different branch information"
   "origin <BRANCH>", "download a specific branch"

.. csv-table::
   :header: Example, Explanation
   :widths: 20, 20

   "origin devel", "download the devel branch"

git add
~~~~~~~

Stage commits.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   ".", "add all changes to files in the currently working directoy and below to be committed"
   "<FILE>", "add all changes to a specific file to be committed"

git commit
~~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-m '<USEFUL_COMMENT>'", "provide a commit comment"
   "--amend", "change the last commit message"

git push
~~~~~~~~

Upload commits to a git repository.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "origin", "push all local commits, branches, and tags to the remote origin"
   "origin <TAG>", "upload a new read-only tag branch"
   "origin master", "upload your changes to the master branch"
   "origin --delete <BRANCH>", "delete a remote branch"
   "-f, --force", "force a push that will rewrite the commit history to mirror the local commits"

git branch
~~~~~~~~~~

Manage branches.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "show local branches"
   "-b", "create a new branch"
   "-d", "delete a branch"
   "-D", "delete a remote branch; use 'git push origin :<BRANCH>' to fully remove it after this command is run"
   "-a", "show all local and remote branches"
   "-r", "show remote branches only"
   "-m", "rename a branch"

git tag
~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "show tags"
   "<TAG>", "create a special tag branch; useful for saving specific versions of a software"

git checkout
~~~~~~~~~~~~

Change the currently active branch.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<BRANCH>", "use a different branch"
   "--track -b", "checkout a remote branch"

git merge
~~~~~~~~~

Merge one or more commits between branches.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<BRANCH_TAG_OR_COMMIT>", "merge a specified branch to the current branch"

git reset
~~~~~~~~~

Undo changes to the current branch.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "<BRANCH>@{#}", "switch to a specific commit"
   "--soft HEAD~1", "undo the last saved commit; the file changes will be preserved"
   "--hard HEAD~1", "undo the last saved cimmit; all changes from the current commit will be lost"
   "--hard", "remove all uncommitted changes"

git stash
~~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "save", "temporarily save uncommited changes in a branch and revert to HEAD; this is useful for saving changes and then switching to another branch"
   "pop", "revert back from HEAD to the commited changes"

git fsck
~~~~~~~~

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "fix issues with the Git project by syncing against the remote branches"

git count-objects
~~~~~~~~~~~~~~~~~

Count the number of git objects.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "-v", "verbose, show additional size information"
   "-H", "show the size in human readable format"

git log
~~~~~~~

Display the history of commits.

.. csv-table::
   :header: Usage, Explanation
   :widths: 20, 20

   "", "show the commit history of the current branch"
   "-p", "show the commit history of only a specific file or directory"

`History <https://github.com/ekultails/rootpages/commits/master/src/commands/software_configuration_management.rst>`__
----------------------------------------------------------------------------------------------------------------------
