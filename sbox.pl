#! /usr/bin/perl
# Prove the theory that "(b + 1) * k mod 2 ** n + 1" is reversible for all
# possible values b <= 2 ** n - 1 with 2 <= n <= 2 ** n.
#
# Running this script shows that this assumption is not generally true,
# but it holds for several n including n == 8.

sub bad($) {
   warn @_;
   goto back; # What a funny language Perl is! ;-)
}

$max= $ARGV[0];
outer: for ($n= 0; $n <= $max; ++$n) {
   $t= 2 ** $n;
   for ($k= 2; $k <= $t; ++$k) {
      %r= ();
      for ($b= 0; $b < $t; ++$b) {
         $o= ($b + 1) * $k % ($t + 1) - 1;
         bad "negative result $o for b == $b, k == $k and n == $n"
            if $o < 0
         ;
         bad "duplicate mapped value $o from $b for k == $k and n == $n"
            if $r{$o}
         ;
         $r{$o}= 1;
      }
      for ($b= 0; $b < $t; ++$b) {
         bad "Missing mapped value $b for k == $k and n == $n" unless $r{$b};
      }
   }
   back: next outer;
}
print STDERR "All others proved for for n <= $max!\n";
