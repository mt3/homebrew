require 'formula'

class StanfordParser <Formula
  url 'http://nlp.stanford.edu/software/stanford-parser-2010-02-26.tgz'
  homepage 'http://nlp.stanford.edu/software/lex-parser.shtml'
  md5 '25e26c79d221685956d2442592321027'
  version '1.6.2'

  def install
    # has no dependencies (other than Java 5)
    # works right out of the box
    # need to include the parser in PATH
    prefix.install Dir['*']
  end
end
