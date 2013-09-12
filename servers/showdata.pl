use v5.16;
use AE;
use AnyEvent::Socket;
use Getopt::Long;
$|++;

my $port = '8080';
GetOptions('port|p=i' => \$port);

say 'listening on port:'.$port;

my $cv = AE::cv;

tcp_server '127.0.0.1', $port, sub {
	my ($fh, $host ,$port) = @_;
	say "new connection from host: $host | port : $port";
	my $w; $w = AE::io $fh, 0, sub {
        my $len = sysread $fh, my $content, 64;
        do {undef $w;say "connection from host : $host port: $port disconnected";return} if $len == 0;
        say $content. "from host : $host"; 
	};
};
$cv->recv;

__END__

# you can use -p or --port to set port