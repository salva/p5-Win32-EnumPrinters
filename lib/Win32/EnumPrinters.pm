package Win32::EnumPrinters;

our $VERSION = '0.01';

use 5.010;
use strict;
use warnings;

use Win32::EnumPrinters::Constants;

require Exporter;
our @ISA = qw(Exporter);
our %EXPORT_TAGS; # Win32::EnumPrinters::Constants initializes this!
$EXPORT_TAGS{subs} = [qw( EnumPrinters EnumForms GetDefaultPrinter)];

my %all;
@all{@$_} = @$_ for values %EXPORT_TAGS;
our @EXPORT_OK = keys %all;
$EXPORT_TAGS{all} = \@EXPORT_OK;



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

1;
__END__

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
