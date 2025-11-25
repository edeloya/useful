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
  input_dir="$(dirname "$1")"
  base_name="$(basename "$1" | sed 's/\.[^.]*$//')"

  # Convert to WAV in-place and pipe to Whisper-cli
  ffmpeg -i "$input_file" -ac 1 -ar 16000 -f wav - |\
  ~/whisper.cpp/build/bin/whisper-cli -f - \
  -m ~/whisper.cpp/models/ggml-base.en.bin \
  -l en -otxt -of "$input_dir/$base_name"
}
EOF
fi
