# Dot Files

- [Installation](#installation)
- [Updating](#updating)
- [Customizing Your Bash Shell](#customizing-your-bash-shell)
- [Git Configuration Overrides](#git-configuration-overrides)
- [Git Commit Signing](#git-commit-signing)
- [Miscellaneous Stuff](#miscellaneous-stuff)

## Installation

To use this repository, you need to clone the repo and run the install script. I recommend cloning the repo into your home directory, but it should work from any directory.

```bash
# Clone the repo
git clone https://git.codingallnight.com/chris/dotfiles.git

# Run the install script
dotfiles/install
```

The install script will take any pre-existing dotfiles that would be overwritten by the installation process and rename them by appending **.old** to the end of the filename. For example, your **.bashrc** file will be renamed to **.bashrc.old**. Then, the script creates symlinks in your home directory that point to files in the cloned repository.

If you don't want to install some features included in this repo, then you can just remove the symlink after installation. For example, if you don't want the git prompt then you can run `rm ~/.git-prompt.sh` to remove it.

## Updating

To update your dotfiles, all you have to do is pull the latest revision of the repository. Because all the dotfiles are symlinked from the home directory, you don't need to re-run the install script.

## Customizing Your Bash Shell

If you want to customize the **.bashrc** file, you can add a file to your home directory called **.bashrc.local** and the **.bashrc** file will automatically source it. See the [**bashrc.local.example**](bashrc.local.example) file in this repo for an example.

## Git Configuration Overrides

You can customize the **.gitconfig** by creating a **.gitconfig.local** file in your home directory. It will be automatically included at the end of the **.gitconfig** file and will override any settings in that file. You can even include more configuration files from your **.gitconfig.local** file to support more advanced configurations or conditional includes. See the example in the [**gitconfig.local.example**](gitconfig.local.example) file in this repo.

## Git Commit Signing

> This requires Git v2.34.0 or newer and OpenSSH v8.0 or newer, excluding OpenSSH v8.7 which is broken.

This repo contains default git configuration for signing commits with the default ED25519 SSH key. This configuration is not in the main **.gitconfig** file though, because it would break Git on unsupported versions or if referenced files did not exist. Instead, it exists in the [**gitconfig.local.example**](gitconfig.local.example).

To use it, copy the example config file to your home directory and modify it as needed:

```bash
cp dotfiles/gitconfig.local.example ~/.gitconfig.local
```

The SSH key used for signing is defined by `user.signingKey`. This must point to an ED25519 or RSA private key.

The SSH allowed signers file is defined by `gpg.ssh.allowedSignersFile`. This is highly recommended so that you can verify signed commits.

You can create an allowed signers file with the correct email address and key using this command:

```bash
# Replace <signing-key>.pub with the public key matching your private key in user.signingKey
echo "$(git config --get user.email) namespaces=\"git\" $(cat ~/.ssh/<signing-key>.pub)" >> ~/.ssh/allowed_signers
```

If you have multiple SSH keys that are used to sign your commits, for example if you work on multiple computers with different keys, then you probably want to add all your SSH public keys used to sign commits to this allowed signers file. Otherwise you'll see signature errors when viewing commit signatures. You can add signing keys from other people as well to verify their commit signatures.

You can now use the `--show-signature` flag to view the signature status of commits in several commands, like `git log --show-signature` or `git show --show-signature`.

## Miscellaneous Stuff

This repository also include several files/directories that are not installed and exist only for my convenience.

- **bin/** contains custom scripts I've created and find useful.
- **ssh/** contains the public keys for some of my SSH key pairs.
- **examples.tar.gz** contains the following 2 directories:
  - **example-files/** is a directory of many different files types. It is useful when testing out a new syntax highlighting theme.
  - **test-directory.tar.bz2** is a directory of all the different types of files, directories, and symlinks. It is useful when testing out a new **.dircolors** file.



[_modeline]: # ( vi: set ts=4 sw=4 et wrap ft=markdown: )
