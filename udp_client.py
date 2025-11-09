#!/usr/bin/env python3
import socket

# Put the server IP here (if server on same machine use 127.0.0.1)
SERVER_IP = input("Enter server IP (or press Enter for localhost): ").strip() or "127.0.0.1"
PORT = 6000

client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

print("UDP Client started. Type 'exit' to end.")

try:
    while True:
        msg = input("You: ").strip()
        if not msg:
            continue
        client_socket.sendto(msg.encode(), (SERVER_IP, PORT))

        if msg.lower() == "exit":
            print("You ended chat.")
            break

        data, server = client_socket.recvfrom(1024)
        reply = data.decode().strip()
        print("Server:", reply)

        if reply.lower() == "exit":
            print("Server ended chat.")
            break
finally:
    client_socket.close()

on new terminal
sudo apt update
sudo apt install python3


python3 udp_client.py



A socket is an endpoint for sending or receiving data across a computer network.
In UDP socket programming, communication occurs in a connectionless manner, meaning the server and client do not establish a dedicated connection before data transfer.

Each message, called a datagram, is sent individually and may arrive out of order or get lost, but it provides low latency and faster communication.

UDP is suitable for real-time applications such as video streaming, VoIP, or simple message exchange where reliability is less critical.

Server Side (UDP Server):-
Import the socket module.
Create a UDP socket using
Bind the socket to a host (IP) and port number.
Continuously receive data from clients using recvfrom().
Decode and display the received message.
Accept server input and send it back to the client using sendto().
Exit the loop when the message is "exit".
Close the socket.

Client Side (UDP Client):-
Import the socket module.
Create a UDP socket using
Enter the server IP and port number.
Take user input and send it to the server using sendto().
Wait for a reply using recvfrom() and display it.
Repeat until the user enters "exit".
Close the socket.
