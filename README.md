##### Dotfiles Setup

Save up for dotfiles

###### Requirements

- [Chezmoi](https://www.chezmoi.io/quick-start/) : Install with `brew install chezmoi`

###### Utils

- Add config :

  - `chezmoi add ~/your/config/file`

- Setup a new machine:

  - `chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git`
  - Update: `chezmoi update -v`

- Save up:

  - `chezmoi cd` and just push a commit to the repo

- Edit a config Nvim:
  - `<space>sz`
