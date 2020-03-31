#!/bin/bash

in1=$1
in2=$2
out="diff.jpg"

cmp() {
    msg=$1
    metric=$2
    a=$3
    b=$4
    opts=$5
    out=$6
        
    echo "-----------"
    echo "$msg"
    printf '%s ' '-'
    if [ -z "$opts" ]; then
        magick compare -metric "$metric" "source-images/$a" "source-images/$b" "$out"
    else
        magick compare -metric "$metric" $opts "source-images/$a" "source-images/$b" "$out"
    fi
    rc=$?
    echo
    if [ "$rc" = 0 ]; then
        echo "- rc: $rc (passed)"
    else
        echo "- rc: $rc (failed)"
    fi
    echo "- wrote $out"

}

echo "this compares a png and a jpg image derived from a tiff image using ImageMagick."
echo "the comparison will fail with a non-zero return code if the two images are not 'similar'." 
echo "the magic number that is emitted are the number of pixels considered 'different'."
echo "the degree of similarity/difference can be controlled using the '-fuzz' parameter."
echo
echo "'pae' is 'Peak Absolute Error (normalised)."
echo "the pae value will tell us the fuzz factor needed for the two to be similar."
echo
echo "'ae' is the 'Absolute Error' count."
echo "the number it emits are the number of pixels that are not identical"

# more about the different types of metrics here:
# https://imagemagick.org/www/script/command-line-options.php#metric

cmp "png with jpg (pae, no fuzz)" pae default.jpg default.png "" png--jpg--pae.png

cmp "png with jpg (ae, no fuzz)" ae default.jpg default.png "" png--jpg--ae.png

cmp "png with jpg (ae, fuzz 1%)" ae default.jpg default.png "-fuzz 1%" png--jpg--fuzz01.png

cmp "png with jpg (ae, fuzz 5%)" ae default.jpg default.png "-fuzz 5%" png--jpg--fuzz05.png

# at 10% we have 863 non-identical pixels
# this manifests as very slight differences in the aliasing
cmp "png with jpg (ae, fuzz 10%)" ae default.jpg default.png "-fuzz 10%" png--jpg--fuzz10.png

cmp "png with jpg (ae, fuzz 15%)" ae default.jpg default.png "-fuzz 15%" png--jpg--fuzz15.png

cmp "png with jpg (ae, fuzz 20%)" ae default.jpg default.png "-fuzz 20%" png--jpg--fuzz20.png

# at 25% there are 4 non-identical pixels
cmp "png with jpg (ae, fuzz 25%)" ae default.jpg default.png "-fuzz 25%" png--jpg--fuzz25.png

# PAE indicated this value with 0.36 
cmp "png with jpg (ae, fuzz 36%)" ae default.jpg default.png "-fuzz 36%" png--jpg--fuzz36.png

echo
echo "the pae value indicated the fuzz factor required to achieve zero differences (36%)"
echo "now lets compare the default.jpg with bad.jpg"
echo

cmp "(good) jpg with (bad) jpg (pae, no fuzz)" pae default.jpg bad.jpg "" jpg--bad-jpg--mepp.png

cmp "(good) jpg with (bad) jpg (ae, no fuzz)" ae default.jpg bad.jpg "" jpg--bad-jpg--pae.png

echo
echo "the pae value here is 1 (100% different)"
echo "lets fuzz it a little bit and see how the total number of different pixels goes down"
echo 

cmp "(good) jpg with (bad) jpg (ae, fuzz 10%)" ae default.jpg bad.jpg "-fuzz 10%" jpg--bad-jpg--fuzz10.png

cmp "(good) jpg with (bad) jpg (ae, fuzz 20%)" ae default.jpg bad.jpg "-fuzz 20%" jpg--bad-jpg--fuzz20.png

cmp "(good) jpg with (bad) jpg (ae, fuzz 30%)" ae default.jpg bad.jpg "-fuzz 30%" jpg--bad-jpg--fuzz30.png

cmp "(good) jpg with (bad) jpg (ae, fuzz 40%)" ae default.jpg bad.jpg "-fuzz 40%" jpg--bad-jpg--fuzz40.png

cmp "(good) jpg with (bad) jpg (ae, fuzz 50%)" ae default.jpg bad.jpg "-fuzz 50%" jpg--bad-jpg--fuzz50.png

cmp "(good) jpg with (bad) jpg (ae, fuzz 75%)" ae default.jpg bad.jpg "-fuzz 75%" jpg--bad-jpg--fuzz75.png

cmp "(good) jpg with (bad) jpg (ae, fuzz 99%)" ae default.jpg bad.jpg "-fuzz 99%" jpg--bad-jpg--fuzz99.png
