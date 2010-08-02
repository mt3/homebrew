# TODO: rename lexparser-gui.csh to lexparser-gui.command
# TODO: must also rename stanford-parser-2010-02-06.jar to stanford-parser.jar (MAYBE NOT NECESSARY?)
# TODO: write uninstall script that removes all symlinks, etc.
# TODO: this ain't going to work since the user needs to change their .zshrc file to add custom paths

require 'formula'

class StanfordParser <Formula
  url 'http://nlp.stanford.edu/software/stanford-parser-2010-02-26.tgz'
  homepage 'http://nlp.stanford.edu/software/lex-parser.shtml'
  md5 '25e26c79d221685956d2442592321027'
  version '1.6.2'
  # might have to do something with:
  JAR = 'stanford-parser.jar'

  def install
    #FileUtils.mkdir prefix+`lib`
    
    # install files into directories
    (prefix+"lib").install JAR
    #(prefix+"lib").install Dir["*.jar"]
    prefix.install Dir["*"]
    #prefix.install Dir["*.txt"] + Dir["{bin,interface,javadoc}"]
    
    # install a shell script in bin that executes .jar file using the script at bottom of file
    (bin+'stanford_parser').write(eval('"'+DATA.read+'"'))
    
    puts " "
    puts "#{prefix+'doc'+'html'}"
    puts "#{HOMEBREW_PREFIX}"
    puts "PREFIX: #{prefix}"
    puts "BIN: #{bin}"
    puts "LIBEXEC: #{libexec}"
    puts share
    puts " "
    
    # create symlinks
    FileUtils.ln_s "#{prefix}/lexparser.csh", "#{HOMEBREW_PREFIX}/bin/"
    FileUtils.ln_s "#{prefix}/makeSerialized.csh", "#{HOMEBREW_PREFIX}/bin/"
    FileUtils.ln_s "#{prefix}/lexparser-ar-rosetta.sh", "#{HOMEBREW_PREFIX}/bin/"
    FileUtils.ln_s "#{prefix}/lexparser-gui.csh", "#{HOMEBREW_PREFIX}/bin/"
    
    #remove Windows files
    rm Dir["#{prefix}/*.{bat,dll,exe}"]
  end
  
  def caveats
    "This software requires Java 5 (JDK 1.5.0+).
      Check that the command \"java -version\" works and gives 1.5+."
  end
end



__END__
#!/bin/sh
for i in web util trees swing stats process parser objectbank movetrees misc math ling io international fsm
do
  PATH=$PATH:#{prefix}/src/edu/stanford/nlp/$i
done
echo $PATH

#ST_PARSER=#{prefix+"lib"}/#{JAR}
ST_PARSER=#{prefix}/#{JAR}
echo
echo java -jar ${ST_PARSER} ${@}
echo
java -jar $ST_PARSER $@
