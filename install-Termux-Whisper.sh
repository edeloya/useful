#!/bin/bash
set -x
cd ~
pkg update
DEBIAN_FRONTEND=noninteractive pkg upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
pkg install -y git cmake clang make ffmpeg curl
git clone --depth 1 https://github.com/ggerganov/whisper.cpp.git
cd whisper.cpp
cmake -B build
cmake --build build --config Release
bash ./models/download-ggml-model.sh base.en

# Check if transcribe_audio exists
if ! type transcribe_audio &>/dev/null; then
    # Append to bash.bashrc if not
    cat >> "$PREFIX/etc/bash.bashrc" << 'EOF'

# Whisper.cpp
transcribe_audio() {
  if [ $# -lt 1 ]; then
    echo "Usage: transcribe_audio <input_audio_file>"
    return 1
  fi

  input_file="$1"
  input_dir="$(dirname "$input_file")"
  base_name="$(basename "$input_file" | sed 's/\.[^.]*$//')"

  # Convert to WAV in-place and pipe to Whisper-cli
  ffmpeg -i "$input_file" -ac 1 -ar 16000 -f wav - |  ~/whisper.cpp/build/bin/whisper-cli -f - -m ~/whisper.cpp/models/ggml-base.en.bin -l en -otxt -of "$input_dir/$base_name"
}
EOF
fi
