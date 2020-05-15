sudo apt-get build-dep squid
sudo apt-get install devscripts build-essential fakeroot "libssl-dev|libssl1.0-dev"

mkdir sb-tmp
cd sb-tmp
apt-get source squid

cat > squid-ssl.patch << DELIM
--- rules	2018-04-16 15:53:16.247348322 +0100
+++ squid3-3.5.23/debian/rules.orig	2018-04-16 15:51:15.977963770 +0100
@@ -22,6 +22,10 @@
		--mandir=/usr/share/man \\
		--enable-inline \\
		--disable-arch-native \\
+		--enable-ssl \\
+		--enable-ssl-crtd \\
+		--with-openssl \\
+		--enable-linux-netfilter \\
		--enable-async-io=8 \\
		--enable-storeio="ufs,aufs,diskd,rock" \\
		--enable-removal-policies="lru,heap" \\

DELIM

patch squid*/debian/rules < squid-ssl.patch

cd squid*-*/

export DEBEMAIL=ih@imranh.co.uk
export DEBFULLNAME=Imran Hussain

dch -n "Rebuild with (Openm)SSL support."

debuild -us -uc -b
