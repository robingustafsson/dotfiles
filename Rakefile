require 'dotfiles_installer'

desc "install dotfiles into home directory"
task :install do
  DotfilesInstaller::Interactive.new(".", {
    :ignored_filenames => %w[README.md Rakefile bootstrap.sh]
  }).install
end

desc "uninstall dotfiles from home directory"
task :uninstall do
  DotfilesInstaller::Interactive.new(".", {
    :ignored_filenames => %w[README.md Rakefile bootstrap.sh]
  }).uninstall
end
