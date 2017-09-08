#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "Winspool.h"
#include "Stringapiset.h"

#ifndef WC_ERR_INVALID_CHARS
#define WC_ERR_INVALID_CHARS 0x80
#endif

#include "const-c.inc"

union printer_info_all {
    PRINTER_INFO_1W pi1;
    PRINTER_INFO_2W pi2;
//    PRINTER_INFO_3W pi3;
    PRINTER_INFO_4W pi4;
    PRINTER_INFO_5W pi5;
//    PRINTER_INFO_6W pi6;
    PRINTER_INFO_7W pi7;
    PRINTER_INFO_8W pi8;
    PRINTER_INFO_9W pi9;
};

#define DEFAULT_BUFFER_SIZE ((sizeof(union printer_info_all) * 20))

static SV *
wchar2sv(pTHX_ wchar_t *str, size_t wlen) {
    if (str)  {
        size_t len;
        if (!wlen) wlen = wcslen(str);
        if (wlen) {
            len = WideCharToMultiByte(CP_UTF8, WC_ERR_INVALID_CHARS, str, wlen,
                                      NULL, 0, NULL, NULL);
            if (len) {
                SV *sv = newSV(len + 2);
                char *pv = SvPVX(sv);
                if (WideCharToMultiByte(CP_UTF8, WC_ERR_INVALID_CHARS, str, wlen,
                                        pv, len + 1, NULL, NULL) == len) {
                    SvPOK_on(sv);
                    pv[len] = '\0';
                    SvCUR_set(sv, len);
                    SvUTF8_on(sv);
                    return sv;
                }
            }
            Perl_warn(aTHX_ "Unable to convert wide char string to UTF8: %d, str: %p, wlen: %d", GetLastError(), str, wlen);
        }
    }
    return &PL_sv_undef;
}

static SV *
pi1_to_sv(pTHX_ PPRINTER_INFO_1W pi1) {
    HV *hv = newHV();
    SV *sv = sv_2mortal(newRV_noinc((SV*)hv));
    hv_stores(hv, "Flags", newSViv(pi1->Flags));
    hv_stores(hv, "Description", wchar2sv(aTHX_ pi1->pDescription, 0));
    hv_stores(hv, "Name", wchar2sv(aTHX_ pi1->pName, 0));
    hv_stores(hv, "Comment", wchar2sv(aTHX_ pi1->pComment, 0));
    return sv;
}

static SV *
pi2_to_sv(pTHX_ PPRINTER_INFO_2W pi2) {
    HV *hv = newHV();
    SV *sv = sv_2mortal(newRV_noinc((SV*)hv));

    hv_stores(hv, "ServerName", wchar2sv(aTHX_ pi2->pServerName, 0));
    hv_stores(hv, "PrinterName", wchar2sv(aTHX_ pi2->pPrinterName, 0));
    hv_stores(hv, "ShareName", wchar2sv(aTHX_ pi2->pShareName, 0));
    hv_stores(hv, "PortName", wchar2sv(aTHX_ pi2->pPortName, 0));
    hv_stores(hv, "DriverName", wchar2sv(aTHX_ pi2->pDriverName, 0));
    hv_stores(hv, "Comment", wchar2sv(aTHX_ pi2->pComment, 0));
    hv_stores(hv, "Location", wchar2sv(aTHX_ pi2->pLocation, 0));
    // LPDEVMODE pDevMode;
    hv_stores(hv, "SetFile", wchar2sv(aTHX_ pi2->pSepFile, 0));
    hv_stores(hv, "PrintProcessor", wchar2sv(aTHX_ pi2->pPrintProcessor, 0));
    hv_stores(hv, "Datatype", wchar2sv(aTHX_ pi2->pDatatype, 0));
    hv_stores(hv, "Parameters", wchar2sv(aTHX_ pi2->pParameters, 0));
    // PSECURITY_DESCRIPTOR pSecurityDescriptor;
    hv_stores(hv, "Attributes", newSViv(pi2->Attributes));
    hv_stores(hv, "Priority", newSViv(pi2->Priority));
    hv_stores(hv, "DefaultPriority", newSViv(pi2->DefaultPriority));
    hv_stores(hv, "StartTime", newSViv(pi2->StartTime));
    hv_stores(hv, "UntilTime", newSViv(pi2->UntilTime));
    hv_stores(hv, "Status", newSViv(pi2->Status));
    hv_stores(hv, "cJobs", newSViv(pi2->cJobs));
    hv_stores(hv, "AveragePPM", newSViv(pi2->AveragePPM));
    return sv;
}

/* TODO... */
// SV *pi3_to_sv(pTHX_ PPRINTER_INFO_3W pi3) { return &PL_sv_undef; }
SV *pi4_to_sv(pTHX_ PPRINTER_INFO_4W pi4) { return &PL_sv_undef; }
SV *pi5_to_sv(pTHX_ PPRINTER_INFO_5W pi5) { return &PL_sv_undef; }
// SV *pi6_to_sv(pTHX_ PPRINTER_INFO_6W pi6) { return &PL_sv_undef; }
SV *pi7_to_sv(pTHX_ PPRINTER_INFO_7W pi7) { return &PL_sv_undef; }
SV *pi8_to_sv(pTHX_ PPRINTER_INFO_8W pi8) { return &PL_sv_undef; }
SV *pi9_to_sv(pTHX_ PPRINTER_INFO_9W pi9) { return &PL_sv_undef; }


MODULE = Win32::EnumPrinters		PACKAGE = Win32::EnumPrinters

INCLUDE: const-xs.inc


void
EnumPrinters(IV flags, SV *name, IV level)
PREINIT:
    DWORD buffer_size = DEFAULT_BUFFER_SIZE;
PPCODE:
    while (1) {
        DWORD required = 0;
        DWORD items = 0;
        LPBYTE buffer = NULL;
        Newx(buffer, buffer_size, BYTE);
        SAVEFREEPV(buffer);
        if (EnumPrintersW(flags, NULL, level,
                          buffer, buffer_size,
                          &required, &items)) {
            DWORD i;
            for (i = 0; i < items; i++) {
                SV *sv;
                switch (level) {
                case 1:
                    sv = pi1_to_sv(aTHX_ (PPRINTER_INFO_1W)buffer + i);
                    break;
                case 2:
                    sv = pi2_to_sv(aTHX_ (PPRINTER_INFO_2W)buffer + i);
                    break;
                    /* case 3:
                    sv = pi3_to_sv(aTHX_ (PPRINTER_INFO_3W)buffer + i);
                    break; */
                case 4:
                    sv = pi4_to_sv(aTHX_ (PPRINTER_INFO_4W)buffer + i);
                    break;
                case 5:
                    sv = pi5_to_sv(aTHX_ (PPRINTER_INFO_5W)buffer + i);
                    break;
                default:
                    Perl_warn(aTHX_ "level %d not supported", level);
                    sv = &PL_sv_undef;
                    break;
                }
                XPUSHs(sv);
            }
            XSRETURN(items);
        }
        else {
            if (required > buffer_size) {
                buffer_size = required;
                continue;
            }
            XSRETURN(0);
        }
    }
                          
