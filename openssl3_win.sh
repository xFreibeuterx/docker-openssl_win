#!/bin/sh

html=$(wget -qO- https://www.openssl.org/source/ | grep "openssl-3.0")
file_name=$(echo "$html" | grep -oP 'href="\K[^"]+(?=")')
file_version=$(echo "$file_name" | sed -n 1p) 
Version=$(echo "$file_version" | sed 's/.tar.gz//')
Pfad=/home/output
Home=/home/Downloads
Out=OpenSSL-3.0
tmp=tmp
temp=/home/temp

mkdir -p $Home/$tmp
rm $Pfad/$Out.tar.gz
mkdir -p $temp/$Out/bin
chmod -R ugo+rwx $Home/$tmp
chmod -R ugo+rwx $temp

cd $Home
wget https://www.openssl.org/source/$file_version
tar xzfv $Home/$file_version
chmod -R ugo+rwx $Home/$Version

cd $Home/$Version

chmod +x $Home/$Version/Configure
$Home/$Version/Configure --cross-compile-prefix=x86_64-w64-mingw32- mingw64 --prefix=$Home/$tmp --openssldir=$Home/$tmp

make
make install

p -R $Home/$tmp/bin/ $temp/$Out/
cp $Home/$Version/LICENSE.txt $temp/$Out/
cp $Home/$Version/NEWS.md $temp/$Out/
cp $Home/$Version/CHANGES.md $temp/$Out/

cd $temp
tar -czf $Out.tar.gz $Out/
cp $Out.tar.gz $Pfad

chmod -R ugo+rwx $Pfad/