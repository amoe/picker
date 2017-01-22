#! /usr/bin/perl
use DBI;
use strict;
use warnings;
use v5.20.2;
use Data::Dump qw/dump/;
use File::Slurper qw/read_text/;
use Getopt::Long;
use Log::Any qw($log);
use Log::Dispatch;
use Log::Any::Adapter;
use Picker;

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
my $initialize;

GetOptions ("length=i" => \$length,    # numeric
            "file=s"   => \$data,      # string
            "verbose"  => \$verbose,
            "initialize" => \$initialize)   # flag
    or die("Error in command line arguments\n");

sub main {
    $log->debugf("Starting.");

    if ($initialize) {
        $log->debugf("Scanning...");
        my $scan = Picker::scan_dir(@_);
        $log->debugf("Scan completed.");

        # Do stuff...
        Picker::save_scan($scan);

    } else {
        my $existing_scan = Picker::load_scan()
            or die "Can't find existing scan, please initialize first";
    }

    $log->debugf("End.");
}

main @ARGV;
