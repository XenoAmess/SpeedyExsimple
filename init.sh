CODENAME=`lsb_release -c -s`
wget -O - http://nuitka.net/deb/archive.key.gpg | apt-key add -
echo >/etc/apt/sources.list.d/nuitka.list "deb http://nuitka.net/deb/stable/$CODENAME $CODENAME main"
apt update
apt install autoconf libtool libsysfs-dev screen nuitka

screen -S exsimple -X quit

autoreconf -vfi

mkdir /SpeedyExsimple/environments
mkdir /SpeedyExsimple/files

cd /SpeedyExsimple/environments
git clone https://github.com/openssl/openssl
git clone https://github.com/madler/zlib
git clone https://github.com/nginx/nginx

cp -r /SpeedyExsimple/environments/nginx/* /SpeedyExsimple/
chmod 777 /SpeedyExsimple/environments/pcre-8.42/configure
cd /SpeedyExsimple
./auto/configure --prefix=/SpeedyExsimple --conf-path=/SpeedyExsimple/nginx.conf --with-pcre=/SpeedyExsimple/environments/pcre-8.42 --with-zlib=/SpeedyExsimple/environments/zlib --with-http_ssl_module --with-openssl=/SpeedyExsimple/environments/openssl --with-http_geoip_module
make
make install

rm /SpeedyExsimple/nginx.conf
cp /SpeedyExsimple/SpeedyExsimple.conf /SpeedyExsimple/nginx.conf

nginx

cd /SpeedyExsimple
wget -O /SpeedyExsimple/src/exsimple.py https://raw.githubusercontent.com/XenoAmess/EXsimple/master/src/exsimple.py
sed -i "s/THIS_IS_DAILYPASTE = False;/THIS_IS_DAILYPASTE = True;/g" /SpeedyExsimple/src/exsimple.py
nuitka --standalone  --recurse-all  --python-version=3.5  /SpeedyExsimple/src/exsimple.py  --output-dir=/SpeedyExsimple/sbin/  --remove-output
sudo screen -dmS exsimple sudo /SpeedyExsimple/sbin/exsimple.dist/exsimple.exe dir=/SpeedyExsimple/files/ port=7777
