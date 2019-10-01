#!/bin/sh
n=test014m
if [ x$DWTOPSRCDIR = "x" ]
then
  top_srcdir=$top_blddir
else
  top_srcdir=$DWTOPSRCDIR
fi
srcdir=$top_srcdir/test
base=$srcdir/$n.base

# This test should fail on all as we don't allow outpath
# in the dwarf_object_detector_path call.
o=$srcdir/kask2/dwarfdump_G4
#echo "START test $n "
./object_detector  $o  >junk.$n.tmp
dos2unix  junk.$n.tmp 2>/dev/null

rm -f junkz
echo sx $srcdir xyyyx | sed s/\ //g >junkz
y=`cat junkz`
sed $y < junk.$n.tmp >junk.$n
rm -f junkz

diff $base junk.$n > junk.$n.out
if [ $? -ne 0 ]
then
  head -30 junk.$n.out
  echo "FAIL $n.sh $cmd, results differ $base vs junk.$n.out"
  echo "To update, mv junk.$n $base"
  exit 1
fi
exit 0

