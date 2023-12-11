Pry.config.commands.command 'pbcopy', 'Copy input to clipboard' do |input|
  input = input ? target.eval(input) : _pry_.last_result
  IO.popen('pbcopy', 'w') { |io| io << input }
end

Pry.config.commands.command 'html-view', 'Write input to and html file and open it' do |input|
  input = input ? target.eval(input) : _pry_.last_result

  require 'tempfile'
  file = Tempfile.new(['pry-result', '.html'])
  begin
    file.write(input)
    file.rewind
    `open #{file.path}`
    sleep 1
  ensure
    file.unlink
  end
end
