To use this repository, you need to checkout the repo into a directory in your home directory. Then `cd` into that directory and run the install script.

```bash
git clone https://gitlab.codingallnight.com/chris/dotfiles.git [directory-name]
cd [directory-name]
./install.sh
```

The install script will take any pre-existing dotfiles that would be overwritten by the installation process and rename them by appending `.old` to the end of the filename. For example, your `.bashrc` file will be renamed to `.bashrc.old`. Then, the script creates symlinks in your home directory that point to files in the repository.

If you want to customize the `.bashrc` file, you can add a file to your home directory called `.bashrc.local` and the `.bashrc` file will automatically source it. You can see an example of this file in the repo.

If you don't want to install some features included in this repo, then you can just remove the symlink after installation. For example, if you don't want the git prompt then you can run `rm ~/.git-prompt.sh` to remove it.

To update your dotfiles, all you have to do is pull the latest revision of the repository. Because all the dotfiles are symlinked from the home directory, you don't need to re-run the install script.

This repository also include several files/directories that are not installed and exist only for my convenience.

- `example-files/` is a directory of many different files types. It is useful when testing out a new syntax highlighting theme.
- `test-directory.tar.bz2` is a directory of all the different types of files, directories, and symlinks. It is useful when testing out a new `.dircolors` file.
- `ssh/` contains the public ssh keys for some of my computers.