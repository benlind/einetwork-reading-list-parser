#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use feature ':5.10';

=pod

=head1 NAME

library_list_parse.pl - Parses an exported eiNetwork Library Reading History
file into tab-delimited output.

=head1 SYNOPSIS

perl library_list_parse.pl [file]

$file defaults to 'export.txt'.

=head1 DESCRIPTION

See README.md for full description.

=cut

my $filename = $ARGV[0] // 'export.txt';
open my $file, '<', $filename;

=head2 trim([$string1, [$string2, ...]])

trim() removes whitespace from the beginning and end of any passed
strings. NOTE: It modifies the passed variables IN-PLACE, changing their
referenced values, not copies. If no strings are passed, it operates on $_, so
that you can call `trim` without arguments.

=cut
sub trim { return @_ ? do { s/^\s+|\s+$//g for @_ } : s/^\s+|\s+$//g };

my @records;
my $i = 0;
my $prev_title = 0; # was the previous line part of a title?
while (<$file>) {
    if (/^Record \d+ of /) {
        $i++;
        $records[$i] = {};
    }
    elsif (/^AUTHOR/) {
        $_ =~ s/^AUTHOR\s+//;
        trim;
        $records[$i]->{author} = $_;
    }
    elsif (/^PUBLISHER/) {
        $_ =~ s/^PUBLISHER\s+//;
        trim;
        $records[$i]->{publisher} = $_;
    }
    elsif (/^TITLE/) {
        $_ =~ s/^TITLE\s+//;
        trim;
        $records[$i]->{title} = $_;
        $prev_title = 1;
    }
    elsif ($prev_title && /^ /) {
        # The previous line was part of a title, which wrapped to this line.
        trim;
        $records[$i]->{title} .= ' ' . $_;
    }
    else {
        $prev_title = 0;
    }
}

# Print the records, delimited by tabs.
my $delim = "\t";
for $i (1 .. $#records) {
    my $title = $records[$i]{title} || '';
    my $author = $records[$i]{author} || '';
    my $publisher = $records[$i]{publisher} || '';
    print $title . $delim;
    print $author . $delim;
    print $publisher . $delim;
    print "\n";
}
