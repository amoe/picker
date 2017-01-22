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
    files  => [
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/01-mystery_fish.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/11-tuff.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/15-molecules.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/06-supercell.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/10-kirby.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/04-dorks.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/08-get_out_of_the_car.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/07-blood_sandwich.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/12-lazy_eye.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/03-lotta_years.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/13-defender.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/09-shrunk.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/14-water_tower.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/02-rings.mp3",
                "/home/amoe/music/aesop_rock/2016-the_impossible_kid/05-rabies.mp3",
              ],
    length => 2919733,
  },
};

is_deeply(
    Picker::scan_dir($test_directory),
    $expected,
    "scanning directory"
);


done_testing();
