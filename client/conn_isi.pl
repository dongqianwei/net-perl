use v5.16;
use IO::Socket::INET;
use Getopt::Long;
$|++;

my ($host, $port) = ('127.0.0.1','8080');
GetOptions (
	'host|h=s' => \$host,
	'port|p=i' => \$port,
);

say "peer host: $host port: $port";
my $soc = IO::Socket::INET->new(
	PeerHost => "$host:$port",
    Proto    => 'tcp',
    Reuse    => 1,
    Timeout  => 6,
);

while ($soc->connected) {
	print 'input data or type q|quit to quit:';
	my $data = <>;
	last if $data =~ /q|quit/i;
	$soc->send($data);
	say 'data send complete';
}

$soc->close;
say 'bye~';