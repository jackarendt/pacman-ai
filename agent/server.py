"""A simple server that handles a UDP socket on port 8888."""
import random
import socket
import sys

PORT = 8888
HOST = ''

if __name__ == '__main__':
  print('Pacman Reinforcement Agent Server.')
  print('Binding Socket on port:', PORT)
  try:
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.bind(('', PORT))
  except socket.error as msg:
      print('error: ' + str(msg[0]) + ' message ' + msg[1])
      sys.exit()

  print('Waiting on port:', PORT)
  while 1:
    data, addr = s.recvfrom(1024)

    if not data:
      break

    # TODO: Decode input, send to model, do other steps, and return actual movement.
    reply = str(random.randint(1, 4))
    s.sendto(reply.encode(), addr)
    print('Message[' + addr[0] + ':' + str(addr[1]) + '] - ' + data.decode('utf-8').strip()  + ' -> ' + reply)

  s.close()
