packet_marker = []
characters = open('input.txt', 'r').read()
position = 0

while True:
    character = characters[position]
    position += 1

    if len(packet_marker) >= 4:
        packet_marker.pop(0)

    packet_marker.append(character)

    if len(packet_marker) == 4 and len(set(packet_marker)) == 4:
        break

print(position)
