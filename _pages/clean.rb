#!/home/firstuser/.rvm/rubies/ruby-2.1.2/bin/ruby

require 'byebug'

#byebug

#puts ARGV[0]

# ![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/arch_Diagrams/architecture_diagram_08.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/arch_Diagrams/architecture_diagram_08.png)

File.open( ARGV[0], "r" ) do |f|
  f.each do |line|
    if line =~ /^!\[http:(.*)\]\((.*)\)$/
	    file = $1.gsub(/.*\//,'').gsub(/\..*/,'')
		  source_image = `find /home/firstuser/dev/bbb-images -name #{file}.png | head -n 1`.chop
	    #puts line
      #puts "cp #{source_image} /home/firstuser/dev/ffdixon.github.io/images"
      `cp #{source_image} /home/firstuser/dev/ffdixon.github.io/images`
      puts "![#{file}](/images/#{file}.png)"
    else
      puts line
    end
  end
end
