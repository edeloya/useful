#!/bin/bash
set -x
cd ~
pkg update
DEBIAN_FRONTEND=noninteractive\
  pkg upgrade -y\
  -o Dpkg::Options::="--force-confdef"
pkg install -y git cmake clang make ffmpeg curl
git clone --depth 1 https://github.com/ggerganov/whisper.cpp.git
cd whisper.cpp
cmake -B build
cmake --build build --config Release
bash ./models/download-ggml-model.sh base.en

if ! type transcribe_audio &>/dev/null; then
  cat >> "$PREFIX/etc/bash.bashrc" << 'EOF'


# Whisper.cpp
transcribe_audio() {
  # Convert to WAV in-place and pipe to Whisper-cli
  ffmpeg -i "$1" -ac 1 -ar 16000 -f wav - |\
  ~/whisper.cpp/build/bin/whisper-cli -f - \
  -m ~/whisper.cpp/models/ggml-base.en.bin \
  -l en -otxt -of "$(dirname "$1")/$(basename "$1" | sed 's/\.[^.]*$//')"
}
EOF
fi
yes | termux-setup-storage >/dev/null 2>&1
echo -e "\n\nRun:\n. \$PREFIX/etc/bash.bashrc"
