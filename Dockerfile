# docker build -t="rails" .

FROM ubuntu

RUN apt-get update

## MYSQL
#RUN apt-get install -y -q mysql-client libmysqlclient-dev 

## POSTGRES

RUN apt-get install -y -q postgresql-9.1
RUN apt-get install -y -q libpq-dev

## RUBY
RUN apt-get -y install build-essential git zsh
RUN apt-get install -y -q ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

## For execjs - needs node
RUN apt-get install -y python-software-properties python python-setuptools 
RUN add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nodejs
# Install git

## RBENV
# Install rbenv
#RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
#RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
#RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
#RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
#RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
#RUN chmod +x /etc/profile.d/rbenv.sh
 
# install ruby-build
#RUN mkdir /usr/local/rbenv/plugins
#RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
 
#ENV RBENV_ROOT /usr/local/rbenv
 
#ENV PATH "$RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# does not work. PATH is set to
# $RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
 
# install ruby2
#RUN sudo /usr/local/rbenv/bin/rbenv install 2.0.0-p247
#RUN sudo /usr/local/rbenv/bin/rbenv global 2.0.0-p247


## RAILS
RUN gem install rails --no-ri --no-rdoc
RUN gem install passenger
## RAILS APP
#ADD ./docker-rails /srv/docker-rails
RUN git clone https://github.com/IconoclastLabs/teamweb.git
# git@github.com:IconoclastLabs/teamweb.git /srv/teamweb-rails
RUN cd /srv/teamweb-rails;bundle install
EXPOSE 3000

#RUN easy_install supervisor
#RUN echo_supervisord_conf > /etc/supervisord.conf
#RUN printf "[include]\nfiles = /srv/teamweb-rails/Supervisorfile\n" >> /etc/supervisord.conf

#CMD ["/usr/local/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
CMD ["/bin/bash/"]

CMD ["/srv/teamweb-rails/script/rails server"]
