#! /usr/bin/perl
$n= 8;
$f= 42;
#
$t= 2 ** $n;
for($a= 0; $a < $t; ++$a) {
	$b= ($a + 1) * $f % ($t + 1) - 1;
	print "$a -> $b\n";
}
