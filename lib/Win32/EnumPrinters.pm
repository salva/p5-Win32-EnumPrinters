package Win32::EnumPrinters;

use 5.024001;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Win32::EnumPrinters ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.

our %EXPORT_TAGS = ( flags      => [qw( PRINTER_ENUM_LOCAL
                                        PRINTER_ENUM_NAME
                                        PRINTER_ENUM_SHARED
                                        PRINTER_ENUM_CONNECTIONS
                                        PRINTER_ENUM_NETWORK
                                        PRINTER_ENUM_REMOTE
                                        PRINTER_ENUM_CATEGORY_3D
                                        PRINTER_ENUM_CATEGORY_ALL
                                        PRINTER_ENUM_EXPAND
                                        PRINTER_ENUM_CONTAINER
                                        PRINTER_ENUM_ICON1
                                        PRINTER_ENUM_ICON2
                                        PRINTER_ENUM_ICON3
                                        PRINTER_ENUM_ICON4
                                        PRINTER_ENUM_ICON5
                                        PRINTER_ENUM_ICON6
                                        PRINTER_ENUM_ICON7
                                        PRINTER_ENUM_ICON8 )],

                     attributes => [qw( PRINTER_ATTRIBUTE_DIRECT
                                        PRINTER_ATTRIBUTE_DO_COMPLETE_FIRST
                                        PRINTER_ATTRIBUTE_ENABLE_DEVQ
                                        PRINTER_ATTRIBUTE_HIDDEN
                                        PRINTER_ATTRIBUTE_KEEPPRINTEDJOBS
                                        PRINTER_ATTRIBUTE_LOCAL
                                        PRINTER_ATTRIBUTE_NETWORK
                                        PRINTER_ATTRIBUTE_PUBLISHED
                                        PRINTER_ATTRIBUTE_QUEUED
                                        PRINTER_ATTRIBUTE_RAW_ONLY
                                        PRINTER_ATTRIBUTE_SHARED
                                        PRINTER_ATTRIBUTE_FAX
                                        PRINTER_ATTRIBUTE_FRIENDLY_NAME
                                        PRINTER_ATTRIBUTE_MACHINE
                                        PRINTER_ATTRIBUTE_PUSHED_USER
                                        PRINTER_ATTRIBUTE_PUSHED_MACHINE
                                        PRINTER_ATTRIBUTE_TS )],

                     status     => [qw( PRINTER_STATUS_BUSY
                                        PRINTER_STATUS_DOOR_OPEN
                                        PRINTER_STATUS_ERROR
                                        PRINTER_STATUS_INITIALIZING
                                        PRINTER_STATUS_IO_ACTIVE
                                        PRINTER_STATUS_MANUAL_FEED
                                        PRINTER_STATUS_NO_TONER
                                        PRINTER_STATUS_NOT_AVAILABLE
                                        PRINTER_STATUS_OFFLINE
                                        PRINTER_STATUS_OUT_OF_MEMORY
                                        PRINTER_STATUS_OUTPUT_BIN_FULL
                                        PRINTER_STATUS_PAGE_PUNT
                                        PRINTER_STATUS_PAPER_JAM
                                        PRINTER_STATUS_PAPER_OUT
                                        PRINTER_STATUS_PAPER_PROBLEM
                                        PRINTER_STATUS_PAUSED
                                        PRINTER_STATUS_PENDING_DELETION
                                        PRINTER_STATUS_POWER_SAVE
                                        PRINTER_STATUS_PRINTING
                                        PRINTER_STATUS_PROCESSING
                                        PRINTER_STATUS_SERVER_UNKNOWN
                                        PRINTER_STATUS_TONER_LOW
                                        PRINTER_STATUS_USER_INTERVENTION
                                        PRINTER_STATUS_WAITING
                                        PRINTER_STATUS_WARMING_UP )],

                     subs       => [qw( EnumPrinters )] );

my %all;
@all{@$_} = @$_ for values %EXPORT_TAGS;
our @EXPORT_OK = keys %all;
$EXPORT_TAGS{all} = \@EXPORT_OK;


our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Win32::EnumPrinters', $VERSION);

sub AUTOLOAD {
    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
        no strict 'refs';
        *$AUTOLOAD = sub { $val };
    }
    goto &$AUTOLOAD;
}

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Win32::EnumPrinters - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Win32::EnumPrinters;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Win32::EnumPrinters, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Salvador Fandiño, E<lt>salva@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2017 by Salvador Fandiño

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.24.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
