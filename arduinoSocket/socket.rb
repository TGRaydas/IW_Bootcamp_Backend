require 'socket' # Provides TCPServer and TCPSocket classes
require 'digest/sha1'

server = TCPServer.new('0.0.0.0', 2345)

loop do

  # Wait for a connection
  socket = server.accept
  STDERR.puts "Incoming Request"

  # Read the HTTP request. We know it's finished when we see a line with nothing but \r\n
  http_request = ""
  while (line = socket.gets) && (line != "\r\n")
    http_request += line 
  end

  # Grab the security key from the headers. If one isn't present, close the connection.
  puts http_request

  socket.close
end