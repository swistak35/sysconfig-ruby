require 'rubygems'
require 'mongrel'

class Sysconfig < Mongrel::HttpHandler
  def process(request, response)
    response.start(200) do |headers, output|
      headers["Content-Type"] = 'text/html'
      output.write(prepare_output)
      reset_vars
    end
  end
  
  def initialize(theme="default")
    puts "===Starting Sysconfig-ruby with template: #{theme}"
    @template = File.readlines("themes/#{theme}/index.html").join
  end
  
  def prepare_output
    template = @template.clone
    vars = template.scan(/%.+?%/)
    vars.each do |var|
      output = eval(var[1..-2].downcase)
      template.gsub!(var,output.to_s)
    end
    template
  end
  
  def reset_vars
    @var_filesystems = nil
  end
end

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
