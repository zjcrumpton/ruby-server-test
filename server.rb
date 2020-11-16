require 'socket'
# require './game/lib/game.rb'
# require './game/lib/grid.rb'
# require './game/lib/node.rb'
# require './game/lib/player.rb'
# require 'colorize'

class Server
  def initialize(port)
    @server = TCPServer.new(port)
    @connections = []
    puts "Listening on port #{port}"
  end

  def start
    Socket.accept_loop(@server) do |connection|
      @connections << connection
      puts @connections
      connection.puts '
      ZJCrumpton Presents:
  
       /$$$$$$                                                /$$           /$$   /$$
      /$$__  $$                                              | $$          | $$  | $$
     | $$  \__/ /$$$$$$ /$$$$$$$ /$$$$$$$  /$$$$$$  /$$$$$$$/$$$$$$        | $$  | $$
     | $$      /$$__  $| $$__  $| $$__  $$/$$__  $$/$$_____|_  $$_/        | $$$$$$$$
     | $$     | $$  \ $| $$  \ $| $$  \ $| $$$$$$$| $$       | $$          |_____  $$
     | $$    $| $$  | $| $$  | $| $$  | $| $$_____| $$       | $$ /$$            | $$
     |  $$$$$$|  $$$$$$| $$  | $| $$  | $|  $$$$$$|  $$$$$$$ |  $$$$/            | $$
      \______/ \______/|__/  |__|__/  |__/\_______/\_______/  \___/              |__/
  
  
                                                                                     '
      Thread.new do
        loop do
          handle(connection)
        end
      end
    end
  end

  private

  def handle(connection)
    request = connection.gets
    connection.close if request.nil?
    @connections.each do |client|
      next if client.closed?
      client.puts(request) if client != connection && !client.closed?
    end
  end
end

server = Server.new(5555)
server.start
