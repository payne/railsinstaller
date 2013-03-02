# RailsInstaller shell script for installing Ruby & Rails on Ubuntu systems
# by Svilen Vassilev, rubystudio.net
# read LICENSE file for details

#Ask for user details to be used by Git
echo "Please enter your email (to be used for configuring Git): "
echo "(Leave blank if Git already installed)"
read input_email
echo "Please enter your first and last names (to be used for configuring Git): "
echo "(Leave blank if Git already installed)"
read input_first_name input_last_name

PS3='Please enter your desired Ruby version: '
options=("Ruby 1.9.3" "Ruby 2.0.0" "Quit")
select opt in "${options[@]}"

# Install the requisite Ubuntu packages
sudo apt-get install -y git-core wget curl gcc checkinstall libxml2-dev libxslt-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev libc6-dev libssl-dev libmysql++-dev make build-essential zlib1g-dev libicu-dev redis-server nodejs openssh-server libreadline-dev libyaml-0-2 libyaml-dev libncurses5-dev zlib1g-dev libgdbm-dev 

# Configure Git
git config --global user.email $input_email
git config --global user.name "$input_first_name $input_last_name"

do
  case $opt in
    "Ruby 1.9.3")
      echo "You chose Ruby 1.9.3"
      # Download and install Ruby 1.9.3
      wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p392.tar.gz
      tar xfvz ruby-1.9.3-p392.tar.gz
      cd ruby-1.9.3-p392
      ./configure
      sudo make
      sudo make install

      # Return to user home directory
      cd ~

      # Delete leftovers
      rm -rf ruby-1.9.3-p392
      rm ruby-1.9.3-p392.tar.gz
      rm ruby.sh
      ;;

    "Ruby 2.0.0")
      echo "You chose Ruby 2.0.0"
      # Download and install Ruby 2.0.0
      wget http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p0.tar.gz
      tar xfvz ruby-2.0.0-p0.tar.gz
      cd ruby-2.0.0-p0
      ./configure
      sudo make
      sudo make install

      # Return to user home directory
      cd ~

      # Delete leftovers
      rm -rf ruby-2.0.0-p0
      rm ruby-2.0.0-p0.tar.gz
      rm ruby.sh
      ;;

    "Quit")
      break
      ;;
    *) echo invalid option;;
  esac
done


# Update rubygems
sudo gem update --system

# Install rake and rails
sudo gem install rake bundler rails

# Say goodbye
echo ""
echo "Ruby and Rails successfully installed! Happy coding!"