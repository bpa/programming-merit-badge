#! /usr/bin/env perl

use strict; # Don't allow variables to be used until they are defined
use warnings; # Be more helpful about pointing out possible errors
use Term::ANSIColor; #provide extra methods for colored output

# Have DATA filehandle point to beginning of file
# This way we can color the source
seek DATA, 0, 0;

#qw means quote word, same as ('a','b','c'), but you don't use whitespace instead of quoting
my @colors = qw/red green yellow blue magenta cyan white/;
my @bg_colors = qw/on_black on_red on_green on_yellow on_blue on_magenta on_cyan on_white/;

# Read each line of this file (now conveniently starting at the top)
while (<DATA>) {
	# Substitute the matched text with a colored version
	# You can change the match to be any regular expression
	# s means substitute
	# (.*) means match everything and make the matched text available later (in $1)
	# c($1) is a little magic because it is actually a function call, not a standard replace
	# g means global, as in, find all the things, not just one
	# e means to execute the replacement and use its return as the value to be replaced
	s/(.*)/colorize($1)/ge;
	print;
}

sub colorize {
	# Pull one argument off the parameter list and assign it to $word
	# This is the $1 from above
	my $word = shift;

	# Pick a random color from this list
	my $color = $colors[rand(@colors)];
	
	return colored($word, $color);
}

__DATA__
If you don't have a __DATA__ section, you don't get to use the DATA filehandle
