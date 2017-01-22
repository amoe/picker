package Picker;

use strict;
use warnings;
use v5.20.2;
use String::ShellQuote qw/shell_quote/;
use Data::Dump qw/dump/;
use File::Find;
use Storable qw(nstore retrieve);

sub get_audio_file_length {
    my $file = shift;
    my $quoted = shell_quote($file);

    my $output = `mediainfo --Inform='General;%Duration%' $quoted`;

    # XXX: Check for failure somehow

    chomp $output;

    return $output;
}

sub get_audio_file_album {
    my $file = shift;
    my $quoted = shell_quote($file);

    my $output = `mediainfo --Inform='General;%Album%' $quoted`;

    # XXX: Check for failure somehow

    chomp $output;

    return $output;
}

# $_ is set to the file here.
sub make_wanted_function {
    my $target_hash_reference = shift;

    return sub {
        if (-f) {
            my $album_name =  get_audio_file_album($File::Find::name);
            my $file_length = get_audio_file_length($File::Find::name);

            if (!exists $target_hash_reference->{$album_name}) {
                # That other other shit
                $target_hash_reference->{$album_name} = {
                    files => [],
                    length => 0
                };
            }

            my $album_datum = $target_hash_reference->{$album_name};

            push(
                @{$album_datum->{files}}, $File::Find::name
            );

            $album_datum->{length} += $file_length;
        }
    }
}

sub scan_dir {
    my @roots = @_;
    my %output = ();

    find(make_wanted_function(\%output), @roots);

    return \%output;
}

sub save_scan {
    my $scan_data = shift;

    say "About to store $scan_data";

    my $config_path = $ENV{HOME} . "/.picker";
    eval {
        mkdir $config_path;
    };
    nstore $scan_data, "${config_path}/scanned.dat";
}

sub load_scan {
    my $config_path = $ENV{HOME} . "/.picker";
    return retrieve("${config_path}/scanned.dat");
}

1;
