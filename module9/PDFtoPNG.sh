#! /bin/bash
#
# This script converts a PDF into a series of PNG images.
# The images will be created in the directory from wich the script is executed.
# Usage: $0 [FILE.PDF|/path/to/FILE.PDF

# Pass in a PDF file.
PDF=$1

#System check so it only runs on GNU/Linux
SYSTEM_CHECK=$(uname -o)
if [ "${SYSTEM_CHECK}" != "GNU/Linux" ]
then
echo "This script was made for the GNU/Linux system you are using: ${SYSTEM_CHECK}"
exit 0
fi

if [ "${PDF}" = *.pdf ]
then
    # Replace ".pdf" with "-slides.png"
    SLIDES=${PDF/.pdf/-slides.png}

    # Replace spaces with hyphens
    SLIDES=${SLIDES// /-}

    # Convert to lowercas
    SLIDES=${SLIDES,,}

    # Extract the basename from the path
    #SLIDES=${basename ${SLIDES}}

    #Convert the PDF into a series of images.
    convert -density 300 "$PDF" -quality 100 ${SLIDES}
else
    echo "Please insert a valid PDF file || Por favor informar o arquivo PDF desejado"
fi