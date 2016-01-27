eiNetwork Library Reading List Parser
=====================================

library_list_parse.pl - Parses an exported eiNetwork Library Reading History
file into tab-delimited output.
    
## Usage

perl library_list_parse.pl [file]

$file defaults to 'export.txt'.

## Description

This script takes an exported eiNetwork Library Reading History list file and
outputs each record's title, author, and publisher. It separates each field with
a tab and each record with a newline. This output can be redirected to a file
and then **imported into Excel** or another spreadsheet program.

All fields in the passed file that are NOT title, author, or publisher will be
ignored.

### Example

This script would take the following file:

```
Record 1 of 3
AUTHOR       Dirr, Michael.
TITLE        Viburnums : flowering shrubs for every season / Michael A. Dirr ;
               illustrations by Bonnie L. Dirr.
PUBLISHER    Portland, Or. : Timber Press, ©2007.

Record 2 of 3
AUTHOR       Cushnie, John.
TITLE        Shrubs for the garden / John Cushnie ; photography by Marianne 
               Majerus.
PUBLISHER    London : Kyle Cathie, ©2004.

Record 3 of 3
AUTHOR       Dickens, Charles, 1812-1870.
TITLE        David Copperfield / Charles Dickens ; with an introduction by 
               Paul Bailey.
PUBLISHER    Oxford ; New York : Oxford University Press, 1999.
```

It would output the following content, which has tabs between each field:

```
Viburnums : flowering shrubs for every season / Michael A. Dirr ; illustrations by Bonnie L. Dirr.	Dirr, Michael.	Portland, Or. : Timber Press, ©2007.
Shrubs for the garden / John Cushnie ; photography by Marianne Majerus.	Cushnie, John.	London : Kyle Cathie, ©2004.
David Copperfield / Charles Dickens ; with an introduction by Paul Bailey.	Dickens, Charles, 1812-1870.	Oxford ; New York : Oxford University Press, 1999.
```

This file can then be imported into Excel with tabs as delimiters.
