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
