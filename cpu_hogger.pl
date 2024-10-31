#!/usr/bin/perl
use v5.10;

# Miguel Lock
# SFE-128-A Spring 2023
# Assignment: Log Parsing 2


sub main {
	#ensures a parameter (text file) was entered
	if(@ARGV) { $router_log = $ARGV[0]; }
	else { print("Please enter a file name as the parameter (Example: \"./cpu_hogger.pl routerlogtest1.txt\")\n"); }

	@signature = (
		'%SEC_LOGIN-5-LOGIN_SUCCESS: Login Success',
		'%SYS-5-CONFIG_I: Configured from console by authuser1 on vty1',
		'%SYS-5-PRIV_AUTH_PASS: Privilege level set',
		'%OS-SYSLOG-4-LOG_WARNING : PAM detected CPU hog for cpu_hogger on 0_RP0_CPU0',
		'%OS-SYSLOG-4-LOG_WARNING : PAM detected /misc/config is full on 0_1_CPU0'
	);

	#opens the file into array @lines
	open(FILE, "<", $router_log) or die "Error: Can't open $router_log";
	my @lines = <FILE>;
	close(FILE);

	$counter = 0;

	for(@lines) {
		$line = $_;

		for(0..4) {
			$i = $_;

			if($line =~ /@signature[$i]/) {  #if the line contains a specific line from @signature
				($device) = @lines[$counter] =~ /^([^\-]+)/; #$device is set to characters before the "-"
				$device =~ s/[\.\-]//g; #removes the "." character from $device

				# if key $device does not exist, create it and set value to 0
				if(!exists($device_hash{$device})) { $device_hash{$device} = 0; }

				if($device_hash{$device} == $i) {
					$device_hash{$device}++;
					push(@$device, @lines[$counter]); #pushes the current line to array @<device_name>
					if($device_hash{$device} == 4) {
						push(@hacked, $device); #pushes name of device to list of hacked devices
					}
				}
			}
		}

		$counter++;
	} #end for(@lines)

	#prints the output to the terminal
	for(@hacked) {
		# $id is everything before the "-" in the name
		if(@$_[0] =~ /^([^\-]+)/) { $id = $&; }

		# $impact is the time of the first line
		if(@$_[0] =~ /\-.*GMT/) { $impact = substr($&, 1); }

		# $detected is the time of the last line 
		if(@$_[4] =~ /\-.*GMT/) { $detected = substr($&, 1); }

		# Print the results
		print("Router ID: $id\tInitial impact: $impact\tIntrusion detected: $detected\n");
	}
} #end main()


main();
