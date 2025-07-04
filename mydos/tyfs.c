#include "bios1.h"
#include "bios2.h"

#define DIR_ENTRY_LEN 32
#define FS_SIGLEN 4

struct fs_header_t
{
    unsigned char  signature[FS_SIGLEN];      /* The file system signature.               */
    unsigned short total_number_of_sectors;   /* Number of 512-byte disk blocks.          */
    unsigned short number_of_boot_sectors;    /* Sectors reserved for boot code.          */
    unsigned short number_of_file_entries;    /* Maximum number of files in the disk.     */
    unsigned short max_file_size;             /* Maximum size of a file in blocks.        */
    unsigned int   unused_space;              /* Remaining space less than max_file_size. */
} __attribute__((packed)) fs_header;

extern char _DIR_ADDR[];

void load_dir();

void f_list()
{
    char                *p;
    struct fs_header_t  *fs_header;

    fs_header = (struct fs_header_t*) 0x7c00;

    load_dir();

    
    for (int i = 0; i < fs_header->number_of_file_entries; i++)
    {
        p = _DIR_ADDR + (i*DIR_ENTRY_LEN);

        if (*p)
        {
            kwrite(p);
            kwrite("\n");
        }
    }
}
