
import socket

# Leave HOST '' to listen on all interfaces, or set to a specific IP.
HOST = ''           # '' means all available network interfaces
PORT = 6000

server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
server_socket.bind((HOST, PORT))

print(f"UDP Server running on {socket.gethostname()}:{PORT} (listening on all interfaces)")

try:
    while True:
        data, addr = server_socket.recvfrom(1024)
        message = data.decode().strip()
        print(f"Client ({addr}): {message}")

        if message.lower() == "exit":
            print("Client ended chat. Closing.")
            break

        reply = input("Server: ").strip()
        server_socket.sendto(reply.encode(), addr)

        if reply.lower() == "exit":
            print("Server ended chat.")
            break
finally:
    server_socket.close()


sudo apt update
sudo apt install python3

python3 udp_server.py
