#!/usr/bin/env bash

set -euo pipefail

CONFIG_REPO="$HOME/Myconfig"

install_pkg() {
if ! dpkg -s "$1" >/dev/null 2>&1; then
echo "Installing $1..."
sudo apt install -y "$1"
else
echo "$1 already installed."
fi
}

echo "=== Update package list ==="
sudo apt update

echo
echo "=== Base Packages ==="

install_pkg curl
install_pkg git
install_pkg zsh
install_pkg unzip
install_pkg snapd

install_pkg build-essential
install_pkg pkg-config
install_pkg libssl-dev
install_pkg cmake
install_pkg ninja-build

install_pkg bat
install_pkg fzf
install_pkg fd-find
install_pkg ripgrep
install_pkg luarocks

echo
echo "=== fd Compatibility ==="

if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
if [ ! -e /usr/local/bin/fd ]; then
sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
fi
fi

echo
echo "=== Rust ==="

if ! command -v rustc >/dev/null 2>&1; then
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
echo "Rust already installed."
fi

if [ -f "$HOME/.cargo/env" ]; then
source "$HOME/.cargo/env"
fi

echo
echo "=== Yazi ==="

if ! command -v yazi >/dev/null 2>&1; then
cargo install --locked yazi-fm yazi-cli
else
echo "Yazi already installed."
fi

echo
echo "=== Neovim ==="

if ! command -v nvim >/dev/null 2>&1; then
sudo snap install nvim --classic
else
echo "Neovim already installed."
fi

echo
echo "=== Kitty ==="

if ! command -v kitty >/dev/null 2>&1; then

```
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.config"

ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/kitty"
ln -sf "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"

cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" \
   "$HOME/.local/share/applications/"

cp "$HOME/.local/kitty.app/share/applications/kitty-open.desktop" \
   "$HOME/.local/share/applications/"

sed -i \
    "s|Icon=kitty|Icon=$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" \
    "$HOME/.local/share/applications/kitty"*.desktop

sed -i \
    "s|Exec=kitty|Exec=$HOME/.local/kitty.app/bin/kitty|g" \
    "$HOME/.local/share/applications/kitty"*.desktop

echo 'kitty.desktop' > "$HOME/.config/xdg-terminals.list"
```

else
echo "Kitty already installed."
fi

echo
echo "=== Oh My Zsh ==="

if [ ! -d "$HOME/.oh-my-zsh" ]; then
RUNZSH=no CHSH=no 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
echo "Oh My Zsh already installed."
fi

echo
echo "=== Powerlevel10k ==="

P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

if [ ! -d "$P10K_DIR" ]; then
git clone --depth=1 
https://github.com/romkatv/powerlevel10k.git 
"$P10K_DIR"
else
echo "Powerlevel10k already installed."
fi

touch "$HOME/.zshrc"

if grep -q '^ZSH_THEME=' "$HOME/.zshrc"; then
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME/.zshrc"
else
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$HOME/.zshrc"
fi


echo 
echo "=== zsh autosuggest and syntax highlight ==="
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting``
git clone https://github.com/junegunn/fzf-git.sh.git

echo
echo "=== Lazygit ==="

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
LAZYGIT_ARCH=$(uname -m | sed -e 's/aarch64/arm64/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${LAZYGIT_ARCH}.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/lazygit

if ! command -v lazygit >/dev/null 2>&1; then

```
TMPDIR=$(mktemp -d)
pushd "$TMPDIR" >/dev/null

LAZYGIT_VERSION=$(
    curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest |
    grep '"tag_name":' |
    cut -d '"' -f 4 |
    sed 's/v//'
)

curl -Lo lazygit.tar.gz \
    "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

tar xf lazygit.tar.gz lazygit

sudo install lazygit /usr/local/bin

popd >/dev/null
rm -rf "$TMPDIR"
```

else
echo "Lazygit already installed."
fi

echo 
echo "=== install delta,xlcip, viu, zellij ==="
sudo apt-get install delta
sudo apt-get install xclip
cargo install viu
cargo install --locked zellij

echo
echo "=== Myconfig Repository ==="

if [ ! -d "$CONFIG_REPO/.git" ]; then
git clone [git@github.com](mailto:git@github.com):TueTran2008/Myconfig.git "$CONFIG_REPO"
else
echo "Updating Myconfig..."
git -C "$CONFIG_REPO" pull --ff-only
fi

echo
echo "=== Kitty Configuration ==="

mkdir -p "$HOME/.config/kitty"

if [ -d "$CONFIG_REPO/kitty" ]; then
cp -rf "$CONFIG_REPO/kitty/"* "$HOME/.config/kitty/"
echo "Kitty configuration copied."
else
echo "WARNING: $CONFIG_REPO/kitty not found."
fi

echo
echo "=== Fonts ==="

mkdir -p "$HOME/.fonts"

if [ -d "$CONFIG_REPO/fonts" ]; then

```
find "$CONFIG_REPO/fonts" \
    -type f \
    -iname "*.zip" \
    -exec unzip -o {} -d "$HOME/.fonts" \;

find "$CONFIG_REPO/fonts" \
    -type f \
    \( -iname "*.ttf" -o -iname "*.otf" \) \
    -exec cp {} "$HOME/.fonts/" \;

fc-cache -fv

echo "Fonts installed."
```

else
echo "WARNING: $CONFIG_REPO/fonts not found."
fi

echo
echo "=== Useful Aliases ==="

# grep -q "alias cat='batcat'" "$HOME/.zshrc" || 
# echo "alias cat='batcat'" >> "$HOME/.zshrc"
#
# grep -q "alias lg='lazygit'" "$HOME/.zshrc" || 
# echo "alias lg='lazygit'" >> "$HOME/.zshrc"
#
# grep -q "alias yy='yazi'" "$HOME/.zshrc" || 
# echo "alias yy='yazi'" >> "$HOME/.zshrc"

echo
echo "=== Default Shell ==="

if [ "$SHELL" != "$(command -v zsh)" ]; then
chsh -s "$(command -v zsh)"
fi

echo
echo "=== Versions ==="

rustc --version || true
cargo --version || true
nvim --version | head -n1 || true
kitty --version || true
zsh --version || true
batcat --version || true
fzf --version || true
fd --version || true
rg --version | head -n1 || true
lazygit --version || true
yazi --version || true

echo
echo "==================================="
echo "Setup completed successfully"
echo "==================================="
echo
echo "Logout/login and run:"
echo "    p10k configure"

