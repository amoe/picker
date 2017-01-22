package Picker;

use strict;
use warnings;
use v5.20.2;
use autodie qw(:all);
use String::ShellQuote qw/shell_quote/;
use Data::Dump qw/dump/;
use File::Find;


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
            $target_hash_reference->{$album_name} = 42;
        }
    }
}

sub scan_dir {
    my $root = shift;
    my %output = ();

    find(make_wanted_function(\%output), $root);

    say dump(\%output);

    return \%output;
}

1;
