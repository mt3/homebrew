# Downloads the tarballs for the given formulae to the Cache

require 'formula'
require 'fileutils'

ARGV.formulae.each do |f|
  if ARGV.include? "--force" or ARGV.include? "-f"
    where_to = `brew --cache #{f.name}`.strip
    FileUtils.rm_rf where_to unless where_to.empty?
  end

  the_tarball = f.downloader.fetch
  if the_tarball.kind_of? Pathname
    md5 = the_tarball.md5
    puts "MD5 is #{md5}"
  end
end
