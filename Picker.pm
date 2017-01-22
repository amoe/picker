package Picker;

use strict;
use warnings;
use v5.20.2;
use autodie qw(:all);
use String::ShellQuote qw/shell_quote/;


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

1;
