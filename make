chmod 777 /SpeedyExsimple/startup
chmod 777 /SpeedyExsimple/shutdown

CODENAME=`lsb_release -c -s`
wget -O - http://nuitka.net/deb/archive.key.gpg | apt-key add -
echo >/etc/apt/sources.list.d/nuitka.list "deb http://nuitka.net/deb/stable/$CODENAME $CODENAME main"
apt update
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

chmod +777 /SpeedyExsimple/environments/pcre-8.42/configure
cd /SpeedyExsimple
./auto/configure --prefix=/SpeedyExsimple --conf-path=/SpeedyExsimple/SpeedyExsimple.conf --with-pcre=/SpeedyExsimple/environments/pcre-8.42 --with-zlib=/SpeedyExsimple/environments/zlib --with-http_ssl_module --with-openssl=/SpeedyExsimple/environments/openssl
make
make install

cd /SpeedyExsimple
wget -O /SpeedyExsimple/src/exsimple.py https://raw.githubusercontent.com/XenoAmess/EXsimple/master/src/exsimple.py
sed -i "s/THIS_IS_DAILYPASTE = False;/THIS_IS_DAILYPASTE = True;/g" /SpeedyExsimple/src/exsimple.py
nuitka --standalone  --recurse-all  --python-version=3.5  /SpeedyExsimple/src/exsimple.py  --output-dir=/SpeedyExsimple/sbin/  --remove-output
