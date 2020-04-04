chmod 777 /SpeedyExsimple/startup
chmod 777 /SpeedyExsimple/shutdown

CODENAME=`lsb_release -c -s`
wget -O - http://nuitka.net/deb/archive.key.gpg | apt-key add -
echo >/etc/apt/sources.list.d/nuitka.list "deb http://nuitka.net/deb/stable/$CODENAME $CODENAME main"
apt update
#install python
apt install python3.7
apt install python3-dev
apt install python3-pip

apt install autoconf libtool libsysfs-dev screen nuitka

autoreconf -vfi

mkdir /SpeedyExsimple/environments
mkdir /SpeedyExsimple/files

cd /SpeedyExsimple/environments
git clone https://github.com/openssl/openssl
git clone https://github.com/madler/zlib
git clone https://github.com/nginx/nginx
wget https://ftp.pcre.org/pub/pcre/pcre-8.42.tar.gz
tar -xf pcre-8.42.tar.gz
rm pcre-8.42.tar.gz

cp -r /SpeedyExsimple/environments/nginx/* /SpeedyExsimple/
rm -r /SpeedyExsimple/environments/nginx/
sed -i "s/-Werror/ /g" /SpeedyExsimple/objs/Makefile

chmod +777 /SpeedyExsimple/environments/pcre-8.42/configure
cd /SpeedyExsimple
./auto/configure --prefix=/SpeedyExsimple --conf-path=/SpeedyExsimple/SpeedyExsimple.conf --with-pcre=/SpeedyExsimple/environments/pcre-8.42 --with-zlib=/SpeedyExsimple/environments/zlib --with-http_ssl_module --with-openssl=/SpeedyExsimple/environments/openssl
make
make install

cd /SpeedyExsimple
wget -O /SpeedyExsimple/src/exsimple.py https://raw.githubusercontent.com/XenoAmess/EXsimple/master/exsimple/exsimple.py
sed -i "s/THIS_IS_DAILYPASTE = False;/THIS_IS_DAILYPASTE = True;/g" /SpeedyExsimple/src/exsimple.py
python3.7 -m nuitka --standalone  --recurse-all  /SpeedyExsimple/src/exsimple.py  --output-dir=/SpeedyExsimple/sbin/  --remove-output
# --python-version=3.7