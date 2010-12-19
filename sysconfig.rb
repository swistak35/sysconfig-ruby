require 'mongrel'

$Template_name = 'default'
$Template = File.readlines('themes/'+$Template_name+'/index.html').join

class Sysconfig < Mongrel::HttpHandler
  def process(request, response)
    response.start(200) do |headers, output|
      headers["Content-Type"] = 'text/html'
      output.write(prepare_output)
      reset_vars
    end
  end
  
  def prepare_output
    template = $Template.clone
    vars = template.scan(/%.+?%/)
    vars.each do |var|
      output = eval(var[1..-2].downcase)
      template.gsub!(var,output.to_s)
    end
    template
  end
  
  def reset_vars
    @var_filesystems=nil
  end
end

require 'commands'
s = Mongrel::HttpServer.new("0.0.0.0","1234")
s.register("/",Sysconfig.new)
s.run.join
