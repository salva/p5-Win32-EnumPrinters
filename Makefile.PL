use 5.024001;
use ExtUtils::MakeMaker;

if (-f "./.git" or !-f "./consts-c.inc" or !-f "./const-xs.inc") {
    warn "Generating constant declarations...\n";
    require ExtUtils::Constant;
    ExtUtils::Constant::WriteConstants(NAME => 'Win32::EnumPrinters',
                                       NAMES => [qw(PRINTER_ENUM_LOCAL
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
                                                    PRINTER_ENUM_ICON8

                                                    PRINTER_ATTRIBUTE_DIRECT
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
                                                    PRINTER_ATTRIBUTE_TS

                                                    PRINTER_STATUS_BUSY
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
                                                    PRINTER_STATUS_WARMING_UP
                                                  )]);
}

WriteMakefile(NAME          => 'Win32::EnumPrinters',
              VERSION_FROM  => 'lib/Win32/EnumPrinters.pm',
              PREREQ_PM     => {},
              ABSTRACT_FROM => 'lib/Win32/EnumPrinters.pm',
              AUTHOR        => 'Salvador Fandino <sfandino@yahoo.com>',
              LICENSE       => 'perl',
              INC           => '-I.' );
