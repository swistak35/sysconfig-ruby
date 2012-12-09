require 'rubygems'
require 'mongrel'
require 'sysconfig_class'
require 'commands'

ARGV.collect! {|arg| arg.to_s}
ARGV[0] ||= "1234"
ARGV[1] ||= "default"
ARGV[2] ||= "0.0.0.0"

web_server = Mongrel::HttpServer.new(ARGV[2],ARGV[0])
puts "===Starting Mongrel Http Server on #{ARGV[2]}, port #{ARGV[0]}"
application = Sysconfig.new(ARGV[1])
web_server.register("/",application)
web_server.run.join
