import numpy as np
import os

path = os.path.dirname(os.path.realpath(__file__))

if os.environ["PATH"].count(path) == 0:
    os.environ["PATH"] += os.pathsep + path

from pydub import AudioSegment

def apply_equal_power_fade(segment: AudioSegment, fade_duration_ms: int, mode: str = "in") -> AudioSegment:
    # convert to numpy
    samples = np.array(segment.get_array_of_samples()).astype(np.float32)

    # split for stereo
    if segment.channels == 2:
        samples = samples.reshape((-1, 2))

    fade_samples = int(segment.frame_rate * fade_duration_ms / 1000)

    # calculate fading envelope
    t = np.linspace(0, 1, fade_samples)
    if mode == "in":
        curve = np.sin(t * (np.pi / 2))
    elif mode == "out":
        curve = np.cos(t * (np.pi / 2))
    else:
        raise ValueError("mode must be 'in' or 'out'")

    # apply fading
    if segment.channels == 1:
        if mode == "in":
            samples[:fade_samples] *= curve
        else:
            samples[-fade_samples:] *= curve
    else:
        if mode == "in":
            samples[:fade_samples, 0] *= curve
            samples[:fade_samples, 1] *= curve
        else:
            samples[-fade_samples:, 0] *= curve
            samples[-fade_samples:, 1] *= curve

    # back to AudioSegment
    samples = samples.astype(np.int16).flatten()
    new_seg = segment._spawn(samples.tobytes())
    return new_seg

# parameters
name = input()
input_file = os.path.join(path, "songs", f"{name}.mp3")
output_folder = os.path.join(path, "songs", name)
block_duration_ms = 10000
fade_duration_ms = 500

# load audio
try:
    audio = AudioSegment.from_mp3(input_file)
except FileNotFoundError as e:
    print(e)
    quit()
total_duration_ms = len(audio)

# create output folder
os.makedirs(os.path.join(path, "songs"), exist_ok=True)
os.makedirs(output_folder, exist_ok=True)

# create blocks with fade
block_index = 0
position = 0

while position < total_duration_ms:
    start = max(position - fade_duration_ms, 0)
    end = position + block_duration_ms

    segment = audio[start:end]

    # fade in
    if position > 0:
        segment = apply_equal_power_fade(segment, fade_duration_ms, mode="in")

    # fade out
    if end < total_duration_ms:
        segment = apply_equal_power_fade(segment, fade_duration_ms, mode="out")
    else:
        # last block
        segment = segment[:(block_duration_ms)]

    # save
    output_path = os.path.join(output_folder, f"{name}{block_index}.mp3")
    segment.export(output_path, format="mp3")

    position += block_duration_ms
    block_index += 1

print(total_duration_ms/1000)
print("index of first timestamp of this song in music.text")
print("index of last empty item of this song in music.text")
print("Song Name")
print("Band Name")
