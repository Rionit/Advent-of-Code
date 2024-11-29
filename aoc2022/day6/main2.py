packet_marker = []
characters = open('input.txt', 'r').read()
position = 0

while True:
    character = characters[position]
    position += 1

    if len(packet_marker) >= 14:
        packet_marker.pop(0)

    if character not in packet_marker and len(packet_marker) == 13 and len(set(packet_marker)) == 13:
        break

    packet_marker.append(character)

print(position)
