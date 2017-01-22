#! /usr/bin/perl
use DBI;
use strict;
use warnings;
use v5.20.2;
use Data::Dump qw/dump/;
use File::Slurper qw/read_text/;
use Getopt::Long;
use autodie qw(:all);
use Log::Any qw($log);
use Log::Dispatch;
use Log::Any::Adapter;


sub init_logging {
    # Send all logs to Log::Dispatch
    my $dispatch_logger = Log::Dispatch->new(
        outputs => [
            [ 'Screen', min_level => 'debug', newline => 1 ],
        ],
    );
    Log::Any::Adapter->set('Dispatch', dispatcher => $dispatch_logger);
}

init_logging();
$log->debugf("arguments are: %s", dump(\@ARGV));


my $data   = "file.dat";
my $length = 24;
my $verbose;

GetOptions ("length=i" => \$length,    # numeric
            "file=s"   => \$data,      # string
            "verbose"  => \$verbose)   # flag
    or die("Error in command line arguments\n");

sub main {
    $log->debugf("Starting.");
    for my $arg (@_) {
        say $arg;
    }
    $log->debugf("End.");
}

main @ARGV;
