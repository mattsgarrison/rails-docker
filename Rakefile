#require 'bundler/setup'

desc "Connect to Docker image's shell"
task :shell, :name do |t, args|
  sh "sudo docker run -t -i #{args.name} /bin/bash"
end

desc "Build Docker image"
task :build do
  sh "sudo docker build -t='rails' ."
end
