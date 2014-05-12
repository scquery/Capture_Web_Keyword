#!/usr/bin/perl
use strict;
use LWP::UserAgent;
#use HTTP::Request::Common qw(GET);
use URI::Escape qw(uri_escape);
my @keywords;
open FL,"keywords.txt" or die $!;
while(<FL>)
{
chomp;
push @keywords,$_;
}
close FH;
my %result;
my $UA=LWP::UserAgent->new();
foreach my $keyword (@keywords){
=my $resp=$UA->get('http://search.51job.com/jobsearch/search_result.php?fromJs=1&jobarea=000000%2C00&funtype=0000&industrytype=00&keyword='.uri_escape($keyword).'&keywordtype=2&lang=c&stype=1&postchannel=0000&fromType=1');
=cut 
my $resp=$UA->get('http://www.symantec.com/connect/search/apachesolr_search/'.uri_escape($keyword).'?filters=type%3Asc_forum%20tid%3A711%20tid%3A1741&retain-filters=1');
#if($resp->code()>=200 && $resp->decoded_content=~m/\/\s(\d+)\<\/td\>/)
print "$keyword\n";
if(($resp->code()>=200 && $resp->decoded_content=~m/Search\sfound\s([\d,]+)\sitems/)||($resp->code()>=200 && $resp->decoded_content=~m/search_result_count":"([\d,]+)"/) )  
 {
   print "$keyword has num of $1 \n";
   $result{$keyword}=$1;
  }
else
  {
   print "In the 51job,We did't find the keyword. \n";
  }
}
print "Now Let's print the result\n";
foreach my $word (sort {$result{$b}<=>$result{$a}} keys %result)
{
print "$word : $result{$word}\n";

} 
