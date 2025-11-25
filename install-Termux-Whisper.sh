#!$PREFIX/bin/bash

set -x
cd ~
pkg update -y && pkg upgrade -y && pkg install -y git cmake clang make ffmpeg curl
git clone --depth 1 https://github.com/ggerganov/whisper.cpp.git && cd whisper.cpp
bash ./models/download-ggml-model.sh base.en

cat >> $PREFIX/etc/bash.bashrc << 'EOF'


# Whisper.cpp function
transcribe_audio() {
  if [ $# -lt 1 ]; then
    echo "Usage: transcribe_audio <input_audio_file>"
    return 1
  fi

  input_file="$1"
  input_dir="$(dirname "$input_file")"
  base_name="$(basename "$input_file" | sed 's/\.[^.]*$//')"

  # Default output file name if not provided
  wav_file="$input_dir/${base_name}_temp.wav"

  # Convert to WAV in same directory
  ffmpeg -i "$input_file" -f wav "$wav_file"

  # Run Whisper (CLI version)
  ~/whisper.cpp/build/bin/whisper-cli -m ~/whisper.cpp/models/ggml-base.en.bin -f "$wav_file" -l en -otxt -of "$input_dir"

  # Clean up temp WAV
  #rm -f "$wav_file"
}
EOF

source $PREFIX/etc/bash.bashrc
