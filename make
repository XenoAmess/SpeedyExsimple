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
wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1f.tar.gz
tar -xf OpenSSL_1_1_1f.tar.gz
rm OpenSSL_1_1_1f.tar.gz

wget https://github.com/madler/zlib/archive/v1.2.11.tar.gz
tar -xf v1.2.11.tar.gz
rm v1.2.11.tar.gz

wget https://github.com/nginx/nginx/archive/release-1.17.9.tar.gz
tar -xf release-1.17.9.tar.gz
rm release-1.17.9.tar.gz

wget https://ftp.pcre.org/pub/pcre/pcre-8.42.tar.gz
tar -xf pcre-8.42.tar.gz
rm pcre-8.42.tar.gz

cp -r /SpeedyExsimple/environments/nginx-release-1.17.9/* /SpeedyExsimple/
rm -r /SpeedyExsimple/environments/nginx-release-1.17.9/

chmod +777 /SpeedyExsimple/environments/pcre-8.42/configure
cd /SpeedyExsimple
./auto/configure --prefix=/SpeedyExsimple --conf-path=/SpeedyExsimple/SpeedyExsimple.conf --with-pcre=/SpeedyExsimple/environments/pcre-8.42 --with-zlib=/SpeedyExsimple/environments/zlib-1.2.11 --with-http_ssl_module --with-openssl=/SpeedyExsimple/environments/openssl-OpenSSL_1_1_1f
sed -i "s/-Werror/ /g" /SpeedyExsimple/objs/Makefile
make
make install

cd /SpeedyExsimple
wget -O /SpeedyExsimple/src/exsimple.py https://raw.githubusercontent.com/XenoAmess/EXsimple/master/exsimple/exsimple.py
sed -i "s/THIS_IS_DAILYPASTE = False;/THIS_IS_DAILYPASTE = True;/g" /SpeedyExsimple/src/exsimple.py
python3.7 -m nuitka --standalone  --recurse-all  /SpeedyExsimple/src/exsimple.py  --output-dir=/SpeedyExsimple/sbin/  --remove-output
# --python-version=3.7