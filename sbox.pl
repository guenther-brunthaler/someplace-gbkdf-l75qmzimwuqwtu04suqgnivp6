#! /usr/bin/perl
# Prove the theory that "(b + 1) * k mod 2 ** n + 1" is reversible for all
# possible values b <= 2 ** n - 1 with 2 <= n <= 2 ** n.
#
# Running this script shows that this assumption is not generally true,
# but it holds for several n including n == 8.

$min= $ARGV[0];
$max= $ARGV[1];
for ($n= $min; $n <= $max; ++$n) {
   $t= 2 ** $n;
   k: for ($k= 2; $k <= $t; ++$k) {
      %r= ();
      for ($b= 0; $b < $t; ++$b) {
         $o= ($b + 1) * $k % ($t + 1) - 1;
         if ($o < 0) {
            warn "negative result $o for b == $b, k == $k and n == $n";
            next k;
         }
         if ($r{$o}) {
            warn "duplicate mapped value $o from $b for k == $k and n == $n";
            next k;
         }
         $r{$o}= 1;
      }
      for ($b= 0; $b < $t; ++$b) {
         unless ($r{$b}) {
            warn "Missing mapped value $b for k == $k and n == $n";
            next k;
         }
      }
   }
}
print STDERR "All other (n, k) proved for for $min <= n <= $max!\n";
