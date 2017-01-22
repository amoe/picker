use Test::More;
use strict;
use Picker;

ok(2 + 2 == 4, 'universe is ok');

my $test_file 
  = "/home/amoe/music/aesop_rock/2016-the_impossible_kid/01-mystery_fish.mp3";

my $test_directory
  = "/home/amoe/music/aesop_rock/2016-the_impossible_kid";

ok(
    Picker::get_audio_file_length($test_file) == 189022,
    "getting audio file length"
);

ok(
    Picker::get_audio_file_album($test_file) == "The Impossible Kid",
    "getting audio file album"
);

my $expected = {
    "The Impossible Kid" => {
        length => 12345678,
        files => [
            "/home/amoe/music/aesop_rock/2016-the_impossible_kid/01-mystery_fish.mp3",
            "/home/amoe/music/aesop_rock/2016-the_impossible_kid/02-rings.mp3"
        ]
    }
};

is_deeply(
    Picker::scan_dir($test_directory),
    $expected,
    "scanning directory"
);


done_testing();
