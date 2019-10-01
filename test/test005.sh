#!/bin/sh
n=test005
if [ x$DWTOPSRCDIR = "x" ]
then
  top_srcdir=$top_blddir
else
  top_srcdir=$DWTOPSRCDIR
fi
srcdir=$top_srcdir/test
base=$srcdir/$n.base
o=$srcdir/libkrb5support.so.0.1.debug

cmd="--print-symtabs"
#echo "START test $n "
./readelfobj $cmd $o  >junk.$n.tmp
dos2unix  junk.$n.tmp 2>/dev/null
rm -f junkz
echo sx $srcdir xyyyx | sed s/\ //g >junkz
y=`cat junkz`
sed $y < junk.$n.tmp >junk.$n

diff $base junk.$n > junk.$n.out
if [ $? -ne 0 ]
then
  head -30 junk.$n.out
  echo "FAIL $n.sh $cmd, results differ $base junk.$n"
  echo "To update, mv junk.$n $base"
  exit 1
fi
exit 0

